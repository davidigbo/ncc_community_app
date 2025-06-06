class AddEventAndStatusToFeedback < ActiveRecord::Migration[7.2]
  def change
    add_reference :feedbacks, :event, null: false, foreign_key: true
    add_column :feedbacks, :status, :integer
  end
end
