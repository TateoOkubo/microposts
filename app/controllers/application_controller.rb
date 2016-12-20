class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # SessionsHelperモジュールを読み込み
  include SessionsHelper
  
  private 
  def logged_in_user
    # ログインしていない時のみ処理
    unless logged_in?
      # store_locationメソッドでアクセスしようとしたURLを保存
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url # ログイン画面へリダイレクト
    end
  end
end
