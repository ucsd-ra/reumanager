class CreateTranscripts < ActiveRecord::Migration
  def self.up
    create_table :transcripts do |t|
      t.integer :user_id, :size 
      t.string :content_type, :filename
      t.timestamps
    end
  end

  def self.down
    drop_table :transcripts
  end
end