class RemoveInterestsFromProfiles < ActiveRecord::Migration[7.2]
  def change
    remove_column :profiles, :interests, :string
  end
end
