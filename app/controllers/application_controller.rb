class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def login_required
    if session[:dropbox_session]
      dropbox_session = get_dropbox_session()
      if dropbox_session.authorized?
        return true
      end
    end
    flash[:warning]='Please login to continue'
    session[:return_to]=request.request_uri
    redirect_to :controller => "dropbox", :action => "authorize"
    return false 
  end
  
  def get_dropbox_session
    Dropbox::Session.deserialize(session[:dropbox_session])
  end
end
