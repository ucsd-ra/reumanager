class CreateRecommenders < ActiveRecord::Migration
  def self.up
    create_table :recommenders do |t|
      t.column :firstname,            :string
      t.column :middlename,           :string
      t.column :lastname,             :string
      t.column :title,                :string
      t.column :department,           :string
      t.column :univeristy,           :string
      t.column :phone,                :integer, :limit => 10
      t.column :email,                :string
      t.timestamps
    end
  end

  def self.down
    drop_table :recommenders
  end
end
