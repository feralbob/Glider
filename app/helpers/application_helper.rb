# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def chat_user
    begin
      @user = User.find(cookies[:login].to_i)
    rescue => ex
      puts ex
    end
    if @user.nil?
      @user = User.new(params[:user])
      @user.username = "user#{Time.now.strftime("%S%M")}#{rand(100)}"
    end
    cookies[:login] = { :value => "#{@user.id}", :expires => 1.day.from_now } if @user.save
    return @user.username
  end

  def chat_destroy_user
    @user = User.find(params[:id])
    @user.destroy
  end

  def get_all_messages
    @messages = Message.find(:all, :order => 'created_at DESC', :limit => 15)
  end
end
