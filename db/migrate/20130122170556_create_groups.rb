class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :groups, :slug
  end
end
