class RelationshipsController < ApplicationController
  before_action :logged_in_user
  
  # フォローする他のユーザIDをパラメータで受け取り，
  # 見つかったユーザを引数としてUserモデルのfollowメソッドを実行
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
  end

  # 現在ユーザのfollowing_relationshipsを検索して他のユーザをフォローしている場合は
  # そのユーザを引数としてUserのunfollowメソッドを実行
  def destroy
    @user = current_user.following_relationships.find(params[:id]).followed
    current_user.unfollow(@user)
  end
end
