class AddStatusToEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :status, :integer
  end
end
