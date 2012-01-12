class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name
      t.timestamps
    end
    
    %w{admin student}.each do |r|
      Role.create!(:name => r)
    end
  end

  def self.down
    drop_table :roles
  end
end
