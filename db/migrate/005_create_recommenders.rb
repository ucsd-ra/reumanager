class CreateRecommenders < ActiveRecord::Migration
  def self.up
    create_table :recommenders do |t|
      t.column :name,                 :string
      t.column :title,                :string
      t.column :department,           :string
      t.column :college,              :string
      t.column :phone,                :integer, :limit => 10
      t.column :email,                :string
      t.timestamps
    end
  end

  def self.down
    drop_table :recommenders
  end
end
