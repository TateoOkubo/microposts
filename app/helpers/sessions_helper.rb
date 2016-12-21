# current_userメソッドとlogged_in?メソッド

module SessionsHelper
  def current_user
    # ||=で左の値がfalseかnilの場合に右の値を代入する
    # @current_user = @current_user || User.find_by(id: session[:user_id])と同じ
    # User.find_by(...)はsession[:user_id]の値に一致するユーザを返す
    # メソッドの最後が代入文ならば，実行後の左辺の値を返す
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  
  def logged_in?
    # !! は右側に続く値が存在するならtrue，そうでないならfalse
    !!current_user
  end
  
  # ログインが必要なページにアクセスしようとした際に，ページのURLをいったん保存し，
  # ログイン画面に遷移してログイン後に再び保存したURLにアクセスする場合に
  # このメソッドを使用する
  def store_location
    # リクエストがGETならsession[:forwarding_url]にリクエストのURLを代入
    session[:forwarding_url] = request.url if request.get?
  end

  # 存在するならtrue, 存在しないならnil
  def profile_exist?
    @find = User.find_by(id: session[:user_id]).profile
    if @find.eql?("")
      @profile_exist = nil
    else
      @profile_exist = true
    end
  end
  
  def region_exist?
    @find = User.find_by(id: session[:user_id]).region
    #binding.pry
    if @find.eql?("")
      @profile_exist = nil
    else
      @profile_exist = true
    end
  end
  
  
end