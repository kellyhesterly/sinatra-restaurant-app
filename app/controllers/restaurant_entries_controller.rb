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

  get '/restaurants/:id/edit' do
    if logged_in?
      @restaurant = RestaurantEntry.find_by(id: params[:id])
      if @restaurant && @restaurant.user_id == current_user
        erb :'/restaurants/edit'
      else
        redirect to '/restaurants/index'
      end
    else
      redirect to '/'
      end
    end

  patch '/restaurants/:id' do
    if logged_in?
      @restaurant = RestaurantEntry.find_by(id: params[:id])
      if @restaurant && @restaurant.user_id == current_user
        if @restaurant.update(params)
          redirect to "/restaurants/#{@restaurant.id}"
        else
          redirect to "/restaurants/:id/edit"
        end
      else
        redirect to '/restaurants/index'
      end
    else
      redirect to '/'
    end
  end

end
