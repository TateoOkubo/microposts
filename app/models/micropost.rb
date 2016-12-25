class Micropost < ActiveRecord::Base
  # それぞれの投稿は特定の１人のユーザのものである
  belongs_to :user
  
  # user_idが存在する
  validates :user_id, presence: true
  # contentが存在し，最大140文字
  validates :content, presence: true, length: { maximum: 140 }
  
  has_many :favorites, foreign_key: 'micropost_id', dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  
  def favorite?(user)
    favorite_users.include?(user)
  end
end
