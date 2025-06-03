class AddDetailsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :role, :integer, default: 0
    add_column :users, :bio, :text
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end
end
