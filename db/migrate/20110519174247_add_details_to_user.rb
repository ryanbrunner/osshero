class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :email, :string
    add_column :users, :github_url, :string
  end
end
