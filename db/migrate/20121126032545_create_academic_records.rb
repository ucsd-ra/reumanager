class CreateAcademicRecords < ActiveRecord::Migration
  def change
    create_table :academic_records do |t|
      t.string :university
      t.date :start
      t.date :finish
      t.string :academic_level
      t.string :degree
      t.float :gpa
      t.float :gpa_range, :default => 4.0
      t.integer :applicant_id
      
      t.timestamps
    end
  end
end
