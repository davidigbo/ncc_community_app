class AddRegistrationDateAndNotesToEventRegistrations < ActiveRecord::Migration[7.2]
  def change
    add_column :event_registrations, :registration_date, :datetime
    add_column :event_registrations, :notes, :text
  end
end
