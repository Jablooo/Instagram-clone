class CreateJoinTableLikes < ActiveRecord::Migration[5.1]
  def change
    create_join_table :photos, :users, table_name: :likes do |t|
      t.index [:photo_id, :user_id], unique: true
      t.timestamp :created_at
    end
  end
end
