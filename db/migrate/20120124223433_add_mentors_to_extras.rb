class AddMentorsToExtras < ActiveRecord::Migration
  def self.up
    add_column :extras, :mentor1, :string
    add_column :extras, :mentor2, :string
    add_column :extras, :mentor3, :string
  end

  def self.down
    remove_column :extras, :mentor3
    remove_column :extras, :mentor2
    remove_column :extras, :mentor1
  end
end
