class AddCustomFieldsToExtras < ActiveRecord::Migration
  def self.up
    add_column :extras, :additional_info, :text
    add_column :extras, :research_interests, :text
    add_column :extras, :career, :text
  end

  def self.down
    remove_column :extras, :research_interests
    remove_column :extras, :additional_info
    remove_column :extras, :career
  end
end
