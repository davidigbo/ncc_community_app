class AddConfirmableToUsers < ActiveRecord::Migration[7.1] # or your Rails version
  def up
    add_column :users, :confirmation_token,   :string
    add_column :users, :confirmed_at,         :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email,    :string # Only if using reconfirmable

    add_index  :users, :confirmation_token, unique: true

    # If you have existing users, mark them as confirmed
    User.update_all(confirmed_at: Time.current)
  end

  def down
    remove_columns :users, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email
  end
end
