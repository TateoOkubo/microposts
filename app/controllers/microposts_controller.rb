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
  
  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    #投稿が現在のユーザでなければroot_urlにリダイレクト
    return redirect_to root_url if @micropost.nil?
    
    # 投稿を削除
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
  
  private
  
  # フォームから受け取ったパラメータのparams[:micropost]のうち，
  # params[:micropost][:content]のみデータの作成に使用するように
  # Strong Parametersを宣言
  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
