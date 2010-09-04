class DropboxController < ApplicationController
  before_filter :login_required, :except => ['authorize']

  def index
    @dirs = get_dropbox_session().list '', {:mode => :dropbox, :suppress_list => false}
  end
  
  def dir
    @dirs = get_dropbox_session().list params[:path], :mode => :dropbox
  end
  
  def authorize
    if params[:oauth_token] then
      dropbox_session = get_dropbox_session()
      dropbox_session.authorize(params)
      session[:dropbox_session] = dropbox_session.serialize # re-serialize the authenticated session

      redirect_to :action => 'index'
    else
      dropbox_session = Dropbox::Session.new('ndp0bm52jobhaeh', '5zehw5xp7ghheno')
      session[:dropbox_session] = dropbox_session.serialize
      redirect_to dropbox_session.authorize_url(:oauth_callback => url_for(:action => 'authorize'))
    end
  end

  def upload
    if request.method == "POST" then
      dropbox_session.upload params[:file], 'stunnel', :mode => :dropbox
      redirect_to(:action => 'index')
    else
      # display a multipart file field form
    end
  end
 end
