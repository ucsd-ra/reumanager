class AddEmailedAtToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :emailed_rejection_letter_at, :datetime
    add_column :users, :emailed_waitlist_letter_at, :datetime
  end

  def self.down
    remove_column :users, :emailed_waitlist_letter_at
    remove_column :users, :emailed_rejection_letter_at
  end
end
