class AddProfileFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :twitter, :string
    add_column :users, :facebook, :string
    add_column :users, :landphone, :string
    add_column :users, :cellphone, :string
  end
end
