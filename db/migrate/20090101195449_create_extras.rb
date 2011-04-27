class CreateExtras < ActiveRecord::Migration
  def self.up
    create_table :extras do |t|
      t.column :user_id,              :integer
      t.column :awards,               :text
      t.column :lab_skills,           :text
      t.column :comp_skills,          :text
      t.column :gpa_comments,         :text
      t.column :learn,                :string
      t.column :personal_statement,   :text
      t.timestamps
    end
    add_index :extras, :user_id, :unique => true
  end

  def self.down
    drop_table :extras
  end
end
