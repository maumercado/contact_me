class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :group_id

      t.timestamps
    end
    add_index :subscriptions, [:user_id, :group_id]
  end
end
