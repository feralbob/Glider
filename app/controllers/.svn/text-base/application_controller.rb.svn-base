# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '4cbe39ff0a9aa8e3ffc8cfb01f137db0'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
 
  filter_parameter_logging :png, :png_data

  # Ajax methods
  def add_new_message
    begin
      unless params[:message].empty? # to avoid empty messages
        @message = Message.new
        @message.user_id = cookies[:login].to_i
        @message.message = params[:message]
        @message.save!
      end
    rescue => ex
      puts ex
    end
    @messages = Message.find(:all, :order => 'created_at DESC', :limit => 15)
    render :partial => 'ajax/get_all_messages', :layout => false
  end

  def get_all_messages
    @messages = Message.find(:all, :order => 'created_at DESC', :limit => 15)
    render :partial => 'ajax/get_all_messages', :layout => false
  end

  def update_user_name
    begin
      @user = User.find(cookies[:login].to_i)
    rescue => ex
      puts ex
    end
    @user = User.new(params[:user]) if @user.nil?
    @user.username = params[:user_name]
    cookies[:login] = { :value => "#{@user.id}", :expires => 1.day.from_now } if @user.save
    render :partial => 'ajax/update_user_name', :layout => false
  end

  private

  def find_if_local
    @is_local = request.env['REMOTE_ADDR'] == '127.0.0.1'
  end

  def authorize_local_access
    find_if_local
    redirect_to :controller => 'audience', :action => 'home' unless @is_local
  end

  def auth_session
    unless session[:token]
      token = ''
      30.times do
        token += (rand * 10).to_i.to_s
      end
      session[:token] = token
    end
  end

end
