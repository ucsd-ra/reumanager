class CreateRecommendations < ActiveRecord::Migration
  def self.up
    create_table :second_recommendations do |t|
      t.integer :user_id, :second_recommender_id
      t.column :known_student,        :string
      t.column :know_capacity,        :string
      t.column :rating,               :string
      t.column :gpa,                  :string
      t.column :gpa_range,            :string
      t.column :undergrad_inst,       :string
      t.column :faculty_comment,      :text
      t.timestamps
    end
    add_index :second_recommendations, :user_id, :unique => true

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
    drop_table :second_recommendations
    drop_table :second_recommenders
  end
end
