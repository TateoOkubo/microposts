class User < ActiveRecord::Base
  # データの保存前にメールアドレスのアルファベットを小文字に
  #before_save はコールバッグで，データ保存前に指定ブロックorメソッドを実行
  before_save { self.email = self.email.downcase }
  
  # nameは空でなく，最大50文字
  validates :name, presence: true, length: { maximum: 50 }
  
  # メールアドレスの正規表現パターンを定義
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  # emailは空でなく，255文字以内で
  # VALID_EAIL_REGEXのパターンに一致し，他と異なる
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensitive: false }
  
  has_secure_password
  
  # それぞれのユーザは複数の投稿を持つことが出来る
  has_many :microposts

end
