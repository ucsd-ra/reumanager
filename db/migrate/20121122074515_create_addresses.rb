class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :label
      t.string :permanent
      t.integer :applicant_id

      t.timestamps
    end
  end
end
