class CreateReplies < ActiveRecord::Migration[7.2]
  def change
    create_table :replies do |t|
      t.references :feedback, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
