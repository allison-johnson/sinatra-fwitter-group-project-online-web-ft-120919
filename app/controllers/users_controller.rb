class UsersController < ApplicationController

    get '/' do
      if logged_in?
        redirect '/tweets'
      else
        erb :'index'
      end #if
    end #get /
    
    get '/signup' do
      #binding.pry 
      if logged_in?
        redirect '/tweets'
      else
        erb :'users/new'
      end #if
    end #new action

    post '/signup' do
      #binding.pry
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect '/signup'
      end #if
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id 
      redirect '/tweets'
    end #create action

    get '/login' do 
      if logged_in?
        #puts "logged in and went to login" #working
        redirect '/tweets'
      else
        erb :'users/login'
      end
    end #get /login

    post '/login' do
      @user = User.find_by(username: params[:username])
      #binding.pry 
      if @user != nil && @user.authenticate(params[:password])      
        session[:user_id] = @user.id 
        redirect to '/tweets' #This is what logout test wants
        #redirect "/users/#{@user.slug}" #what login test wants 
      end #if

      redirect to '/signup' if !logged_in? 
    end #post /login

    get "/users/:slug_name" do
      @user = User.find_by_slug(params[:slug_name])
      erb :'users/show'
    end #show action

    get '/logout' do
      if logged_in?
        session.clear 
        redirect to '/login'
      else
        redirect to '/'
      end
    end

end
