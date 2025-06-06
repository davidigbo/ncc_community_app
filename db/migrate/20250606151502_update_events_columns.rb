class UpdateEventsColumns < ActiveRecord::Migration[7.2]
  def change
    remove_column :events, :event_date, :datetime
    add_column :events, :start_date, :datetime
    add_column :events, :end_date, :datetime
    add_column :events, :location, :string
  end
end
