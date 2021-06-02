class UsersController < ApplicationController

  get '/login' do
    erb :login
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user.authenticate(params[:password])
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
    @user = User.create(params)
  end

  get '/users/:id' do
    "this will be the showpage"
  end
end
