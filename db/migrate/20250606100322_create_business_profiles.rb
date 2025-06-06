class CreateBusinessProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :business_profiles do |t|
      t.string :company_name
      t.string :business_type
      t.string :contact_info
      t.integer :approval_status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
