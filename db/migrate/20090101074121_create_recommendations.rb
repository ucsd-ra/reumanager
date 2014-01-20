class CreateRecommendations < ActiveRecord::Migration
  def self.up
    create_table :recommendations do |t|
      t.integer :user_id, :recommender_id
      t.column :known_student,        :string
      t.column :know_capacity,        :string
      t.column :rating,               :string
      t.column :gpa,                  :string
      t.column :gpa_range,            :string
      t.column :undergrad_inst,       :string
      t.column :faculty_comment,      :text
      t.timestamps
    end
    add_index :recommendations, :user_id
  end

  def self.down
    drop_table :recommendations
  end
end
