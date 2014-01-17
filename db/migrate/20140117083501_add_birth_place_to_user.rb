class AddBirthPlaceToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :birth_place, :string
  end

  def self.down
    remove_column :users, :birth_place
  end
end
