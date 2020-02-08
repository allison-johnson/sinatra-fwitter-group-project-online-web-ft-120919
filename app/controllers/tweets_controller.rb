class TweetsController < ApplicationController

    #index action to display all tweets
    get '/tweets' do
        #load all users' tweets
        if logged_in?
            @tweets = Tweet.all
            @user = current_user
            #binding.pry 
            erb :'tweets/tweets'
        else 
            redirect to '/login'
        end #if 
    end #index action

    get '/tweets/new' do
        if logged_in?
            erb :'tweets/new'
        else
            redirect '/login' 
        end #if
    end

    #create action
    post '/tweets' do
        if params[:content] == ""
            redirect '/tweets/new'
        else
            @tweet = Tweet.new(content: params[:content])
            current_user.tweets << @tweet 
        end #if
    end #create action 

    #show action
    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            erb :'tweets/show'
        else
            redirect '/login'
        end #if
    end #show action

    #edit action
    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by(id: params[:id])
        #binding.pry 
        if logged_in? 
            erb :'tweets/edit' #Build this form
        else
            redirect '/login'
        end #if
    end

    patch '/tweets/:id' do
        #binding.pry 
        if params[:content] == ""
            redirect "/tweets/#{params[:id]}/edit"
        else
            @tweet = Tweet.find_by(id: params[:id])
            @tweet.update(content: params[:content]) 
        end
    end

    delete '/tweets/:id/delete' do
        @tweet = Tweet.find_by(id: params[:id])
        if logged_in? && current_user.username == @tweet.user.username
            Tweet.delete(params[:id])
            redirect '/tweets'
        end #if
    end

end
