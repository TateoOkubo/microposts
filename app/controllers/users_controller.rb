class UsersController < ApplicationController
  before_action :current_user_name, only: [:edit, :update]
  before_action :set_profile, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
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
end
