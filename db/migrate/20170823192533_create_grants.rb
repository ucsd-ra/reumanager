class CreateGrants < ActiveRecord::Migration
  def change
    create_table :grants do |t|
      t.string :program_title
      t.string :institution
      t.string :department
      t.string :program_description
      t.string :subdomain

      t.timestamps
    end
  end
end
