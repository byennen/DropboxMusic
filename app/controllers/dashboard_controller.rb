class DashboardController < ApplicationController
  before_filter :login_required, :except => ['authorize']
  
  def index
    account = get_dropbox_session().account()
    
    @dir_path = "/samples"
    @files = files(get_dropbox_session(), @dir_path)
    @title = "Dashboard"
  end

end
