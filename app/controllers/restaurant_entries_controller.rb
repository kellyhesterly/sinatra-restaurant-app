class RestaurantEntriesController < ApplicationController

  get '/restaurants/new' do
    erb :'/restaurants/new'
  end

  post '/restaurants' do
    if !logged_in?
      flash[:message] = "You must be logged in to view this page"
      redirect to '/'
    end

    if params[:name] != "" && params[:content] != ""
      @restaurant = current_user.restaurant_entries.create(params)
      flash[:message] = "Restaurant entry created successfully"
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
      flash[:message] = "You must be logged in to view this page"
      redirect to '/'
    end
  end

  get '/restaurants/:id' do
    if logged_in?
      @restaurant = RestaurantEntry.find(params[:id])
      erb :'/restaurants/show'
    else
      flash[:message] = "You must be logged in to view this page"
      redirect to '/'
    end
  end

  get '/restaurants/:id/edit' do
    if logged_in?
      @restaurant = RestaurantEntry.find(params[:id])
      if @restaurant && @restaurant.user_id == current_user.id
        erb :'/restaurants/edit'
      else
        flash[:message] = "You are only able to make edits to your own entries. Sorry!"
        redirect to '/restaurants/index'
      end
    else
      flash[:message] = "You must be logged in to view this page"
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
        flash[:message] = "You are only able to make edits to your own entries. Sorry!"
        redirect to '/restaurants/index'
      end
    else
      flash[:message] = "You must be logged in to view this page"
      redirect to '/'
    end
  end

  delete '/restaurants/:id' do
    if logged_in?
      @restaurant = RestaurantEntry.find(params[:id])
      if @restaurant && @restaurant.user_id == current_user.id
          @restaurant.delete
          flash[:message] = "Restaurant entry deleted successfully"
          redirect to '/restaurants'
        else
          flash[:message] = "You are only able to delete your own entries. Sorry!"
          redirect to '/restaurants/index'
      end
    else
      flash[:message] = "You must be logged in to view this page"
      redirect to '/'
    end
  end


end
