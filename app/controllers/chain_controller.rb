class ChainController < ApplicationController 
  before_filter :authorize_local_access, :except => [:audience_list, :vote_up]
  before_filter :auth_session, :only => [:audience_list, :vote_up]

  layout 'chat'

  def audience_list
    @chains = Chain.find(:all, :order => 'id')
    @presentation_running = Chain.presentation_running?
    if @presentation_running
      @current_chain = Chain.current_chain
    end
  end

  def vote_up
    chain = Chain.find(params[:id])
    unless chain.token_voted_already?(session[:token])
      chain.votes += 1
      chain.save
      cvt = ChainVoteToken.new
      cvt.chain_id = chain.id
      cvt.token = session[:token]
      cvt.save
    end
    redirect_to :controller => 'chain', :action => 'audience_list'
  end

  def list
    @slides = Slide.find(:all, :order => 'sequence_id')
    @chains = Chain.find(:all, :order => 'id')
  end

  def new
    chain = Chain.new
    chain.save
    redirect_to :action => 'edit', :id => chain.id
  end

  def edit
    @chain = Chain.find(params[:id])

    # there is probably a better way of doing the description update
    # but I'm on a plane and can't google for it
    if params[:chain] && params[:chain][:description]
      @chain.description = params[:chain][:description]
      @chain.save
    end

    @all_other_chains = Chain.find(:all, :conditions => ['id != ?', @chain.id]) - @chain.exits
  end

  def add_slides
    @chain = Chain.find(params[:id])

    @slides = Slide.find(:all, :order => 'sequence_id')
  end

  def addslide
    chain = Chain.find(params[:chain_id])
    slide = Slide.find(params[:id])
    slide.chain_id = chain.id
    slide.save
    render :nothing => true
  end

  def reorder
    # what does this all do !? documenation FIXME
       puts params.inspect
    chain = Chain.find(params[:id])

    slides = chain.slides

    index = "sortable_list" + params[:id]

    slides.length.times do |i|
      s = slides[i]
      puts "#{s.sequence_id} => #{params[index][i]}"
    end

    slides.length.times do |i|
      puts "i = #{i}"
      slide = slides[i]
      puts "got slide #{slide.id}" 

      new_sequence_id = params[index][i].to_i

      if slide.sequence_id == new_sequence_id
        puts "Slide #{slide.id} is already sequence #{slide.sequence_id} = #{new_sequence_id}"
      else
        puts "changing slide #{slide.id} from sequence #{slide.sequence_id} to #{new_sequence_id}"
        slide.sequence_id = new_sequence_id
        slide.save
      end
    end
    render :nothing => true
  end
end
