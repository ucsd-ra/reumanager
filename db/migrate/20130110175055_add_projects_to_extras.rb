class AddProjectsToExtras < ActiveRecord::Migration
  def self.up
    add_column :extras, :project1, :string
    add_column :extras, :project2, :string
    add_column :extras, :project3, :string
  end

  def self.down
    remove_column :extras, :project3
    remove_column :extras, :project2
    remove_column :extras, :project1
  end
end
