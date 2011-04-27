class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :title
      t.string :participant
      t.string :participant_university
      t.string :faculty_mentor
      t.integer :year

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
