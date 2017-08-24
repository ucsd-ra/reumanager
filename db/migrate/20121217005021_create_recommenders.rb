class CreateRecommenders < ActiveRecord::Migration
  def change
    create_table :recommenders do |t|
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :department
      t.string :organization
      t.string :url
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
