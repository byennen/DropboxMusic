class DashboardController < ApplicationController
  
  def index
    account = get_dropbox_session().account()
    
    @dir_path = "/music"
    @files = files(get_dropbox_session(), @dir_path)
    @title = "Dashboard"
  end

end
