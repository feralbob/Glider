class SlideController < ApplicationController
  before_filter :authorize_local_access, :except => [:png, :png_small_preview, :png_large_preview]
  layout 'chat'

  def view
    @slide = Slide.find(params[:id])
  end

  def png
    @slide = Slide.find(params[:id])
    send_data @slide.png, :type => 'image/png', :disposition => 'inline'
  end

  def png_small_preview
    @slide = Slide.find(params[:id])
    send_data @slide.png_small_preview, :type => 'image/png', :disposition => 'inline'
  end

  def png_large_preview
    @slide = Slide.find(params[:id])
    send_data @slide.png_large_preview, :type => 'image/png', :disposition => 'inline'
  end

  def list
    @slides = Slide.find(:all, :order => 'sequence_id')
  end

  def import
    unless params[:slide]
      @slide = Slide.new
      return
    end

    # we have a file to process

    @slide = Slide.new_from_upload(params[:slide][:uploaded_data])

    redirect_to :controller => 'slide', :action => 'list'
  end
end
