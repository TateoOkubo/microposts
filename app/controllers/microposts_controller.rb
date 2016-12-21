class MicropostsController < ApplicationController
  # ApplicationControllerにあるlogged_in_userメソッドを実行し，
  # ログインしていない場合はcreateメソッド葉実行しないで/loginにリダイレクト
  before_action :logged_in_user, only: [:create]
  
  
  def create
    # パラメータを受け取って現在のユーザに紐づいたMicropostのインスタンスを
    # @micropostに代入
    @micropost = current_user.microposts.build(micropost_params)
    
    # saveを行い
    if @micropost.save
      #成功したらroot_urlである/にリダイレクト
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      # 失敗したらapp/views/static_pages/home.html.erb　のテンプレートを表示
      render 'static_pages/home'
    end
  end
  
  private
  
  # フォームから受け取ったパラメータのparams[:micropost]のうち，
  # params[:micropost][:content]のみデータの作成に使用するように
  # Strong Parametersを宣言
  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
