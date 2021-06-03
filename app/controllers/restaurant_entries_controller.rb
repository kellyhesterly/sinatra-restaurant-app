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
    @restaurants = RestaurantEntry.all
    erb :'/restaurants/index'
  end

  get '/restaurants/:id' do
    @restaurant = RestaurantEntry.find_by(id: params[:id])
    erb :'/restaurants/show'
  end

end
