class RestaurantEntriesController < ApplicationController

  get '/restaurants/new' do
    erb :'/restaurants/new'
  end

  post '/restaurants' do
    if !logged_in?
      redirect to '/'
    end

    if params[:name] != "" && params[:content] != ""
      @restaurant = current_user.restaurant_entries.create(params)
      redirect to "/restaurants/#{@restaurant.id}"
    else
      redirect '/restaurants/new'
    end
  end

  get '/restaurants' do
    if logged_in?
      @restaurants = RestaurantEntry.all
      erb :'/restaurants/index'
    else
      redirect to '/'
    end
  end

  get '/restaurants/:id' do
    if logged_in?
      @restaurant = RestaurantEntry.find_by(id: params[:id])
      erb :'/restaurants/show'
    else
      redirect to '/'
    end
  end

end
