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
  
  # プロフィールは最大100文字
  validates :profile, length: { maximum: 100 }
  # 地域は最大50文字
  validates :region, length: { maximum: 50 }
  
  has_secure_password

end
