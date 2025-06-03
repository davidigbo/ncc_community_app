class RemoveAvatarFromProfiles < ActiveRecord::Migration[7.2]
  def change
    remove_column :profiles, :avatar, :string
  end
end
