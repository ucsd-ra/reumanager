class AddSecondRecRequestAtToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :second_rec_request_at, :datetime
  end

  def self.down
    remove_column :users, :second_rec_request_at
  end
end
