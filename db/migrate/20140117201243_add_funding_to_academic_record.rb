class AddFundingToAcademicRecord < ActiveRecord::Migration
  def self.up
    add_column :academic_records, :funding, :string
  end

  def self.down
    remove_column :academic_records, :funding
  end
end
