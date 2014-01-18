class AddParentEducationLevelToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :father_edu, :string
    add_column :users, :mother_edu, :string
  end

  def self.down
    remove_column :users, :mother_edu
    remove_column :users, :father_edu
  end
end
