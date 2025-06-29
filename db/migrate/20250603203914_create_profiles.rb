class CreateProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :avatar
      t.text :bios
      t.string :interests

      t.timestamps
    end
  end
end
