class AddDetilaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :area, :string
    add_column :users, :discription, :string
  end
end
