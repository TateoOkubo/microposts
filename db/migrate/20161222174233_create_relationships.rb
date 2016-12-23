class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.references :follower, index: true #, foreign_key: true
      t.references :followed, index: true #, foreign_key: true

      t.timestamps null: false
      
      # folower_idとfollower_idのペアがrelationshipとは異なるように複合インデックスを設定
      t.index [:follower_id, :followed_id], unique: true
    end
  end
end
