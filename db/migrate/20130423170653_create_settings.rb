class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :name, :limit => 255, :default => '', :null => false
      t.text :value
      t.string :object_class
      
      t.timestamps
    end
    add_index :settings, :name
  end

end
