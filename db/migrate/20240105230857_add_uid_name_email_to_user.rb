class AddUidNameEmailToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :uid, :string
    add_column :users, :name, :string
    add_column :users, :email, :string
  end
end
