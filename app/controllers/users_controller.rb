class UsersController < ApplicationController

    get '/' do
      erb :'index'
    end #get /
    
    get '/signup' do
      erb :'users/new'
      #Redirect to tweets if already logged in?
    end #new action

    post '/signup' do
      binding.pry
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      redirect '/tweets'
    end #create action

    get '/login' do 
      erb :'users/login'
    end #get /login

    post '/login' do
      @user = User.find_by(username: params[:username])
      binding.pry 
      if @user != nil && @user.authenticate(params[:password])       
        session[:user_id] = @user.id 
      end #if

      if logged_in?
        redirect '/tweets'
      else
        redirect '/signup'
      end #if
    end #post /login

    get '/tweets' do
        puts "I'm here in tweets!"
        #Get current user and load their tweets
      erb :'users/tweets'
    end

end
