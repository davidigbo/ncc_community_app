class ChangeUserIdToBeOptionalInEventRegistrations < ActiveRecord::Migration[7.2]
  def change
    change_column_null :event_registrations, :user_id, true
  end
end
