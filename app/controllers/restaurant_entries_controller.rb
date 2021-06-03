class RestaurantEntriesController < ApplicationController

  get '/restaurants/new' do
    erb :'/restaurants/new'
  end

  post '/restaurants' do
    @restaurant = current_user.restaurant_entries.create(content: params[:content])
    redirect to "/restaurants/#{@restaurant}"
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
