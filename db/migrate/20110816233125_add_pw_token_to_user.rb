class AddPwTokenToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :pw_token, :string
    add_column :users, :pw_token_created_at, :datetime
  end

  def self.down
    remove_column :users, :pw_token_created_at
    remove_column :users, :pw_token
  end
end
