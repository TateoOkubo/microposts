class CreateMutes < ActiveRecord::Migration
  def change
    create_table :mutes do |t|
      t.references :muting_user, index: true
      t.references :muted_user, index: true

      t.timestamps null: false
      
      t.index [:muting_user_id, :muted_user_id], unique: true
    end
  end
end
