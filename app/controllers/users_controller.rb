class UsersController < ApplicationController
  
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
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end      
end
