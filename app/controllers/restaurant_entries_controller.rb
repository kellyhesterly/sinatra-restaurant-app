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
      flash[:message] = "Please make sure 'restaurant name' and 'why you love it' are filled out to create entry"
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
      @restaurant = RestaurantEntry.find(params[:id])
      erb :'/restaurants/show'
    else
      redirect to '/'
    end
  end

  get '/restaurants/:id/edit' do
    if logged_in?
      @restaurant = RestaurantEntry.find(params[:id])
      if @restaurant && @restaurant.user_id == current_user.id
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
      @restaurant = RestaurantEntry.find(params[:id])
      if @restaurant && @restaurant.user_id == current_user.id
        if params[:name] != "" && params[:content] != "" && @restaurant.update(content: params[:content], dish: params[:dish], drink: params[:drink], service: params[:service], price: params[:price], name: params[:name], atmosphere: params[:atmosphere])
          flash[:message] = "Edit successful!"
          redirect to "/restaurants/#{@restaurant.id}"
        else
          flash[:message] = "Please make sure 'restaurant name' and 'why you love it' are not blank"
          redirect to "/restaurants/#{@restaurant.id}/edit"
        end
      else
        redirect to '/restaurants/index'
      end
    else
      redirect to '/'
    end
  end

  delete '/restaurants/:id' do
    if logged_in?
      @restaurant = RestaurantEntry.find(params[:id])
      if @restaurant && @restaurant.user_id == current_user.id
          @restaurant.delete
          redirect to '/restaurants'
      end
    else
      redirect to '/'
    end
  end

end
