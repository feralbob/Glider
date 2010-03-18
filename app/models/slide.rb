class Slide < ActiveRecord::Base
  require 'zip/zip'
  require 'RMagick'

  PNG_SIGNATURE = [137, 80, 78, 71, 13, 10, 26, 10]

  def self.new_from_upload(upload_data)

    Zip::ZipFile.open(upload_data.local_path) do |zipfile|

      zipfile.each do |file|
        if file.file? #is it a file not a symlink or some shit?

          # hacky shit to see if it's a png, should be in a library really.
          io = file.get_input_stream

          signature = []

          #is there a nicer way to do this?
          8.times do
            signature += [io.read(1)[0]]
          end

          if signature.to_a == PNG_SIGNATURE
            # It's a PNG, throw it in the database
            slide = Slide.new

            # figure out the slide number from the filename assuming Keynote spat it out
            # The filename looks something like MySlides.002-005.png
            # Which means 2nd slide, 5th build

            fa = file.name.split('.')
            sequence = fa[fa.size-2]
            if sequence.include?('-')
              slide.slide_id = sequence.split('-')[0].to_i
              slide.slide_build_id = sequence.split('-')[1].to_i
            else
              slide.slide_id = sequence.to_i
              slide.slide_build_id = 0
            end

            slide.png = file.get_input_stream.read

            png = Magick::Image.from_blob(file.get_input_stream.read)[0]
            #png.resize!(0.1)

            slide.png_large_preview = png.resize(0.25).to_blob

            slide.png_small_preview = png.resize(0.1).to_blob

            slide.chain_id = -1

            logger.info "Saving '#{file.name}' to db..."

            slide.save
          end
        end
      end

    end

    # Now we have a set of imported slides with ids, slide ids and build ids but
    # the sequence is out of order as they come in some random order from the zip
    # file so we need to correct that

    i = 0
    Slide.find(:all, :order => 'slide_id, slide_build_id').each do |slide|
      slide.sequence_id = i # this one is fucked about with
      slide.original_sequence_id = i # this is left alone for reference
      slide.save!
      puts "updating slide #{slide.id} with sequence #{i}"
      i += 1
    end

    logger.info 'Done importing'

  end # self.new_from_upload

  def self.reset_presentation
    Slide.update_all(["presented = ?, presenting = ?", false, false])
  end

  def self.current_slide(current_chain = nil)
    current_chain = Chain.current_chain unless current_chain 
    Slide.find(:first, :conditions => ["chain_id = ? AND presenting = ? AND presented = ?", current_chain.id, true, false])
  end

  def self.next_slide
    if Chain.presentation_running?
      current_chain = Chain.current_chain

      slide = Slide.current_slide(current_chain) 

      last_slide = Chain.on_last_slide_in_chain?(current_chain)

      if last_slide
        exits = current_chain.exits

        # FIXME this deals with only one exit - needs to deal with voting etc
        if exits.count == 0
          # end of presentation....
          return nil
        else
          next_chain = exits.first

          next_slide = next_chain.slides.first
          return next_slide
        end
      else
        slides = Slide.find(:all, :conditions => ["chain_id = ? AND presented = ?", current_chain.id, false], :order => 'sequence_id')

        # this could be done in Sql

        next_slide = slides[1]
        return next_slide
      end

    else
      logger.info 'Presentation is not running...'
      #figure out what the first slide is
      Chain.reset_presentation
      Slide.reset_presentation

      entrypoint = Entrypoint.find(:first)

      if entrypoint
        next_chain = entrypoint.chain

        next_slide = next_chain.slides.first
        return next_slide
      else
        # looks like no entrypoint was defined
        return nil
      end
    end

  end

  def self.move_to_next_slide
    if Chain.presentation_running?
      current_chain = Chain.current_chain

      slide = Slide.current_slide(current_chain) 

      last_slide = Chain.on_last_slide_in_chain?(current_chain)

      if last_slide
        logger.info "need to move to next chain..."
        #move to next chain

        exits = current_chain.exits

        # FIXME this deals with only one exit - needs to deal with voting etc
        if exits.count == 0
          # end of presentation....
          logger.info "reached chain with no more exits..."
          redirect_to :action => 'end'
        else
          current_chain.presented = true
          current_chain.save

          chain = exits.first
          chain.presenting = true
          chain.save    

          slide = chain.slides.first
          slide.presenting = true
          slide.save

        end
      else
        logger.info "moving to next slide in chain..."
        #move to next slide in this chain
        slide.presented = true
        slide.save

        logger.info "set slide #{slide.id} to presented"

        slide = Slide.find(:first, :conditions => ["chain_id = ? AND presented = ?", current_chain.id, false], :order => 'sequence_id')

        slide.presenting = true
        slide.save

        logger.info "slide #{slide.id} is the next slide"

        #nothing else to do..?
      end

    else
      logger.info 'Presentation is not running...'
      #figure out what the first slide is
      Chain.reset_presentation
      Slide.reset_presentation

      entrypoint = Entrypoint.find(:first)

      chain = entrypoint.chain
      chain.presenting = true
      chain.save

      slide = chain.slides.first
      slide.presenting = true
      slide.save
    end
  end

end
