class DropboxController < ApplicationController
  before_filter :login_required, :except => ['authorize']

  # ROOT_DIR = "/tmp/jambox/"

  def index
    account = get_dropbox_session().account()
    
    @dir_path = "/music"
    @files = files(get_dropbox_session(), @dir_path)
    @title = "Dashboard"
  end
  
  def create
    path = "/"+params[:create]
    dropbox_session = get_dropbox_session()
    begin
      dropbox_session.create_folder path, :mode => :dropbox
      dropbox_session.create_folder path, :mode => :dropbox
    rescue Dropbox::FileExistsError
    end
    
    account = get_dropbox_session().account()
    
    puts path
    Jam.create(:uid => account.uid, :dir => "/"+path)
    
    redirect_to :controller => 'dropbox', :action => 'dir', :path => path
  end
  
  def dir
    @dir_path = "/music"
    @files = files(get_dropbox_session(), @dir_path)
  end
  
  def authorize
    if params[:oauth_token] then
      dropbox_session = get_dropbox_session()
      dropbox_session.authorize(params)
      session[:dropbox_session] = dropbox_session.serialize # re-serialize the authenticated session

      redirect_to dashboard_url
    else
      dropbox_session = Dropbox::Session.new('gaos6hoy4sbfmbl', 'cm8r1sbmfttpmi0')
      session[:dropbox_session] = dropbox_session.serialize
      redirect_to dropbox_session.authorize_url(:oauth_callback => url_for(:action => 'authorize'))
    end
  end

  def upload_sample
    dropbox_session = get_dropbox_session()
    if request.method == "POST" then
      dropbox_session.upload params[:file], params[:path], :mode => :dropbox
      redirect_to(:action => 'index')
    else
      @dir_path = params[:path]
      @files = files(dropbox_session, @dir_path)
      
      render :action => :dir
    end
  end
  
  def jam
    account = get_dropbox_session().account()
    jam = params["/music/" + :dir]
    
    Jam.create(:uid => account.uid, :dir => jam)
    render :text => "OK"
  end
  
  def download
    dir_path = params[:path]
    
    pid = fork do
      FileUtils.mkdir_p dir_path

      dropbox_session = get_dropbox_session()
      files = files(dropbox_session, dir_path)
      files.each do | file |
  puts "downloading "+file.path
        file_contents = dropbox_session.download file.path, :mode => :dropbox
  puts "downloaded, now writing to "+file.path
        File.open(file.path, 'wb') do |f| f.write(file_contents) end
  puts "done"
      end
    end

    Process.detach(pid)
    render :text => "OK"
  end
  
  # idea
  #   def music(dropbox_session, dir_path)
  #     music = []
  #     jam_files = dropbox_session.list 'music', :mode => :dropbox
  #     jam_files.each do | file | 
  # puts file.path
  #       files << file if ! file.is_dir and file.path =~ /\.(mp3)$/
  #     end
  #     return files
  #   end
 end
