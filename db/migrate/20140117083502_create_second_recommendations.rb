class CreateSecondRecommendations < ActiveRecord::Migration
  def self.up
    create_table :second_recommenders do |t|
      t.column :user_id,              :integer
      t.column :name,                 :string
      t.column :title,                :string
      t.column :department,           :string
      t.column :college,              :string
      t.column :phone,                :string
      t.column :email,                :string
      t.column :waive_rights,         :boolean, :default => false
      t.timestamps
    end
    add_index :second_recommenders, :user_id, :unique => true

  end

  def self.down
    drop_table :second_recommenders
  end
end
