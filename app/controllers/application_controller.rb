require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  helpers do
    def logged_in?
      !!current_user
    end #logged_in?

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end #current_user
  end #helpers

end #class
