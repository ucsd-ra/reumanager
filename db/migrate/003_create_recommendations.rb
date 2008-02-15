class CreateRecommendations < ActiveRecord::Migration
  def self.up
    create_table :recommendations do |t|
      t.column :student_id,           :integer
      t.column :known_student,        :string
      t.column :know_capacity,        :string
      t.column :rating,               :string
      t.column :gpa,                  :string
      t.column :gpa_range,            :string
      t.column :undergrad_inst,       :string
      t.column :faculty_comment,      :text
      t.timestamps
    end
  end

  def self.down
    drop_table :recommendations
  end
end
