class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.column :firstname,            :string
      t.column :middlename,           :string
      t.column :lastname,             :string
      t.column :dob,                  :datetime
      t.column :street,               :string
      t.column :city,                 :string
      t.column :state,                :string
      t.column :zip,                  :string
      t.column :phone,                :string
      t.column :pstreet,              :string
      t.column :pcity,                :string
      t.column :pstate,               :string
      t.column :pzip,                 :string
      t.column :pphone,               :string
      t.column :email,                :string
      t.column :citizenship,          :string
      t.column :cresidence,           :string
      t.column :gender,               :string
      t.column :ethnicity,            :string
      t.column :race,                 :string
      t.column :disability,           :string
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
      t.column :recommender_id,       :integer
      t.column :awards,               :text
      t.column :research_experience,  :text
      t.column :lab_skills,           :text
      t.column :comp_skills,          :text
      t.column :gpa_comments,         :text
      t.column :learn,                :string
      t.column :personal_statement,   :text
      t.column :token,                :string
      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end