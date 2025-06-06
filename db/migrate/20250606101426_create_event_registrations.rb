class CreateEventRegistrations < ActiveRecord::Migration[7.2]
  def change
    create_table :event_registrations do |t|
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
