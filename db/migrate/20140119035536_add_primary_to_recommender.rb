class AddPrimaryToRecommender < ActiveRecord::Migration
  def self.up
    add_column :recommenders, :primary, :boolean, :default => false
  end

  def self.down
    remove_column :recommenders, :primary
  end
end
