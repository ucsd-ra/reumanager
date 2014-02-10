class AddNewFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :first_gen_college, :string
    add_column :users, :free_lunch, :string
  end

  def self.down
    remove_column :users, :free_lunch
    remove_column :users, :first_gen_college
  end
end
