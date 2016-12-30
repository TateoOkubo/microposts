class UsersController < ApplicationController
  before_action :current_user_name, only: [:edit, :update]
  before_action :set_profile, only: [:edit, :update]
  
  
  def show
    @user = User.find(params[:id])
    # ユーザに紐づいたマイクロポストを作成日が新しい順で取得し，@micropostsに
    @microposts = @user.microposts.order(created_at: :desc)
    @microposts = @microposts.page(params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    # 新しい@userのデータを作成
    @user = User.new(user_params)
    if @user.save
      # Railsで一時的なメッセージを表示するためにはredirect_toやrenderの前に
      # flashというハッシュに:success，:alertなどのキーを指定してメッセージを代入
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  # 基本情報の編集画面
  def edit
    #@user = User.find(params[:id])
  end
  
  # 更新処理
  def update
    if @profile.update(user_params)
      flash[:success] = '編集完了！'
      redirect_to (user_path)
    else
      # エラー表示
      flash[:danger] = '更新失敗'
      render 'edit'
    end
  end
  
  # フォローしているユーザの表示
  def followings
    @followings = User.find(params[:id]).following_users.page(params[:page])
    #binding.pry
    #@following = Relationship.where(follower_id: params[:id])
    # フォローしているユーザを検索
    #@following_user = User.find(@following.ids)
    #@following = @following_user #Relationship.where(follower_id: params[:id])
  end
  
  # フォローされているユーザを表示
  def followers
    # .follower_usersでフォローされているユーザの集まりを取得可能
    # app/models/user.rb参考
    @followers = User.find(params[:id]).follower_users.page(params[:page])
  end
  
  private
  
  # プロフィールと地域が加わったので
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :region)
  end
  
  def set_profile
    @profile = User.find(params[:id])
  end
  
  def current_user_name
    @user = User.find(params[:id])
    redirect_to root_path if @user != current_user
  end
  
  def user_params
    params.require(:user).permit(:name, :description, :image)
  end
end