class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.column :firstname,            :string
      t.column :middlename,           :string
      t.column :lastname,             :string
      t.column :street,               :string
      t.column :city,                 :string
      t.column :state,                :string
      t.column :zip,                  :integer, :limit => 9
      t.column :phone,                :integer, :limit => 10
      t.column :pstreet,              :string
      t.column :pcity,                :string
      t.column :pstate,               :string
      t.column :pzip,                 :integer, :limit => 9
      t.column :pphone,               :integer, :limit => 10
      t.column :email,                :string
      t.column :citizenship,          :string
      t.column :cresidence,           :string
      t.column :gender,               :string
      t.column :race,                 :string
      t.column :disability,           :string
      t.column :college,              :string
      t.column :c_start,              :datetime
      t.column :c_end,                :datetime
      t.column :clevel,               :string
      t.column :major,                :string
      t.column :gpa,                  :decimal
      t.column :gpa_total,            :decimal
      t.column :p_college,            :string
      t.column :pc_start,             :datetime
      t.column :pc_end,               :datetime
      t.column :recommender_id,       :integer
      t.column :awards,               :text
      t.column :research_experience,  :text
      t.column :comments,             :text
      t.column :learn,                :string
      t.column :personal_statement,   :text
      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end