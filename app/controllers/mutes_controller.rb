class MutesController < ApplicationController
  before_action :logged_in_user
  
  def create
    @user = User.find(params[:muted_user_id])
    current_user.mute(@user)
  end
  
  def destroy
    @user = current_user.muting_relationships.find(params[:id]).muted_user
    current_user.unmute(@user)
  end
end
