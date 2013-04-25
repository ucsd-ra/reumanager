class AddAttachmentTranscriptToAcademicRecords < ActiveRecord::Migration
  def self.up
    change_table :academic_records do |t|
      t.attachment :transcript
    end
  end

  def self.down
    drop_attached_file :academic_records, :transcript
  end
end
