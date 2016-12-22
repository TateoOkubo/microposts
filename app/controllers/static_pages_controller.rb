class StaticPagesController < ApplicationController
  
  # ログインしている場合は新しいMicropost食らうｓのインスタンスをuser_idに紐づけた状態で初期化
  
  def home
    # current_user.microposts.build　は 
    # Micropost.new(user_id: current_user.id) と同じ
    # 前者の方を使うようにする
    @micropost = current_user.microposts.build if logged_in?
  end
end
