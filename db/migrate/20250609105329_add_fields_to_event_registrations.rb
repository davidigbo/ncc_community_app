class AddFieldsToEventRegistrations < ActiveRecord::Migration[7.2]
  def change
    add_column :event_registrations, :name, :string
    add_column :event_registrations, :email, :string
    add_column :event_registrations, :phone_number, :string
    add_column :event_registrations, :location, :string
    add_column :event_registrations, :profession, :string
  end
end
