class CreateAcademicRecords < ActiveRecord::Migration
  def self.up
    create_table :academic_records do |t|
      t.column :user_id,              :integer
      t.column :college,              :string
      t.column :college_start,        :string
      t.column :college_end,          :string
      t.column :college_level,        :string
      t.column :major,                :string
      t.column :gpa,                  :string
      t.column :gpa_range,            :string
      t.column :p_college,            :string
      t.column :pcollege_start,       :string
      t.column :pcollege_end,         :string
      t.timestamps
    end
  end

  def self.down
    drop_table :academic_records
  end
end
