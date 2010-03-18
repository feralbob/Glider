class PresentationController < ApplicationController
  before_filter :authorize_local_access

  def presenter_display

  end

  def ajax_slide
    #response.headers['Content-Type'] = 'application/x-javascript'
    response.headers['Content-Type'] = 'application/x-json'
    if Chain.presentation_running?
      current_slide_id = Slide.current_slide.id
      render :text => "{presentation_running:true, slide_number: #{current_slide_id}}"
    else
      render :text => "{presentation_running:false}"  

    end
  end

  def stop
    Chain.reset_presentation
    Slide.reset_presentation
    redirect_to :action => 'presenter_display'
  end

  def start
    unless Chain.presentation_running?
      Slide.move_to_next_slide
    end

    redirect_to :action => 'presenter_display'
  end

  def move_to_next_slide
    Slide.move_to_next_slide
    redirect_to :action => 'presenter_display'
  end

  def projector_display
    if Chain.presentation_running?
      @current_slide = Slide.current_slide
    end
  end

end
