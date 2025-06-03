class RenameBiosToBioInProfiles < ActiveRecord::Migration[7.2]
  def change
    rename_column :profiles, :bios, :bio
  end
end
