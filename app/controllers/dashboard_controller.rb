class DashboardController < ApplicationController
  before_filter :authorize_local_access
  layout 'main'

  def index
    @user = User.new
    @user.username = "user#{Time.now.strftime("%S%M")}#{rand(100)}"
  end
end
