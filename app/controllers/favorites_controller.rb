class FavoritesController < ApplicationController
  before_action :logged_in_user
  
  def create
    #binding.pry
    @micropost = Micropost.find(params[:micropost_id])
    current_user.favorite(@micropost)
  end

  def destroy
    #binding.pry
    @micropost = Micropost.find(Favorite.find(params[:id]).micropost_id) #current_user.favorite_microposts.find(params[:id]).micropost
    current_user.unfavorite(@micropost)
  end

end
