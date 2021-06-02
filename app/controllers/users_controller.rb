class UsersController < ApplicationController

  get '/login' do
      erb :login
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/users/#{@user.id}"
    else
      erb :signup
    end
  end

  get '/signup' do
      erb :signup
  end

  post '/signup' do
    if params[:name] == "" || params[:username] == "" || params[:password] == ""
      erb :signup
    else
      @user = User.create(name: params[:name], username: params[:username], password: params[:password])
      session[:user_id] = @user.id
      redirect to "/users/#{@user.id}"
    end
  end

  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    erb :'/users/show'
  end

  get '/logout' do
    @user = User.find_by(id: params[:id])
    session.destroy
    redirect to '/login'
  end
end
