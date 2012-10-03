class AddLearnMoreToExtras < ActiveRecord::Migration
  def self.up
    add_column :extras, :learn_more, :string
  end

  def self.down
    remove_column :extras, :learn_more
  end
end
