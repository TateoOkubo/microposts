# -*- coding: utf-8 -*-
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
  
  # それぞれのユーザは複数の投稿を持つことが出来る
  has_many :microposts

  # foreign_keyのfollower_idにuserのidが入る
  # user.following_relationshipsによって
  # userがフォローしている場合のrelationshipの集まりを取得
  has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  
  # has_many ~ through 文
  # following_relationshipsを経由してフォローしているユーザの集まりを取得
  has_many :following_users, through: :following_relationships, source: :followed
  
  

  has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  
  has_many :follower_users, through: :follower_relationships, source: :follower

  
  mount_uploader :image, ImageUploader
  
  # 他のユーザをフォローする
  # find_or_create_byは引数のパラメータと一致するものを1件取得し，
  # 存在する場合はそのオブジェクトを返し，
  # 存在しなければ引数の内容で新しくオブジェクトを作成し，DBに保存
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end
  
  # フォローしているユーザをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end
  
  # あるユーザをフォローしているかどうか?
  # 他のユーザがfollowing_usersに含まれているかチェック
  def following?(other_user)
    following_users.include?(other_user)
  end
  
  # user_idがフォローしているユーザと自分のつぶやきを取得
  def feed_items
    # following_user_idsは、Userモデルのhas_many :following_usersの部分で自動的に生成されたメソッド
    # user1がこのコードを実行しようとするとself.idはuser1.idとなる
    Micropost.where(user_id: following_user_ids + [self.id])
  end
  
  has_many :favorites, foreign_key: "user_id", dependent: :destroy
  has_many :favorite_microposts, through: :favorites, source: :micropost
  
  def favorite(micropost)
    #binding.pry
    favorites.find_or_create_by(micropost_id: micropost.id)
  end
  
  def unfavorite(micropost)
    favorite = favorites.find_by(micropost_id: micropost.id)
    favorite.destroy if favorite
  end
  
end
