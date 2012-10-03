class CreateAcademicRecords < ActiveRecord::Migration
  def self.up
    create_table :academic_records do |t|
      t.column :user_id,              :integer
      t.column :college,              :string
      t.column :college_start,        :datetime
      t.column :college_end,          :datetime
      t.column :college_level,        :string
      t.column :major,                :string
      t.column :gpa,                  :string
      t.column :gpa_range,            :string
      t.column :p_college,            :string
      t.column :p_college_start,       :datetime
      t.column :p_college_end,         :datetime
      t.column :transcript_file_name,      :string
      t.column :transcript_content_type,  :string
      t.column :transcript_file_size,     :integer
      t.column :transcript_updated_at,    :datetime
      t.timestamps
    end
    add_index :academic_records, :user_id, :unique => true
  end

  def self.down
    drop_table :academic_records
  end
end
