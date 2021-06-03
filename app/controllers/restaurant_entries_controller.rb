class RestaurantEntriesController < ApplicationController

  get '/restaurant/new' do

  end

  post '/restaurant' do

  end

  get '/restaurants' do
    @restaurants = RestaurantEntry.all
    erb :'/restaurants/all'
  end

end
