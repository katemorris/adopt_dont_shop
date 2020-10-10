class RemoveShelterName < ActiveRecord::Migration[5.2]
  def change
    remove_column :pets, :shelter
  end
end
