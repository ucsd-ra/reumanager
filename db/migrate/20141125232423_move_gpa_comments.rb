class MoveGpaComments < ActiveRecord::Migration
  def change
    add_column :applicants, :gpa_comment, :text
  end
end
