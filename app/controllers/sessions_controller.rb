class SessionsController < ApplicationController
  def new
  end
  
  # メールアドレスとパスワードはparams[:session]に入っている
  
  # ログイン処理．ユーザをメールアドレスから検索
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    # もし，ユーザが見つかった場合は，authenticateメソッドでパスワードが正しいか調べる
    if @user && @user.authenticate(params[:session][:password])
      # パスワードが正し場合はsession[:user_id]にユーザIDを入れ，
      # ユーザーの詳細ページにリダイレクト
      session[:user_id] = @user.id
      flash[:info] = "logged in as #{@user.name}"
      redirect_to @user
    else
      # パスワードが間違っている場合はnewテンプレートを表示
      flash[:danger] = 'invalid email/password combination'
      render 'new'
    end
  end

  
  # ログアウト処理
  def destroy
    # session[:user_id]をnilすることでサーバとブラウザの両方でセッションの情報を破棄
    session[:user_id] = nil
    # アプリケーションのルートにリダイレクト
    redirect_to root_path
  end
  
end
