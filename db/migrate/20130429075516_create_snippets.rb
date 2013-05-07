class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :name, :limit => 255, :default => '', :null => false
      t.text :description
      t.text :value

      t.timestamps
    end
  end
end
