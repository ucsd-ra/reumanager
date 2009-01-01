class CreateRecommenders < ActiveRecord::Migration
  def self.up
    create_table :recommenders do |t|
      t.column :user_id,              :integer
      t.column :name,                 :string
      t.column :title,                :string
      t.column :department,           :string
      t.column :college,              :string
      t.column :phone,                :string
      t.column :email,                :string
      t.timestamps
    end
  end

  def self.down
    drop_table :recommenders
  end
end