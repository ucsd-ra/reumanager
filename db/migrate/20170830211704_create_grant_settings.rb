class CreateGrantSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :grant_settings do |t|
      t.string :institute
      t.string :department
      t.string :department_postal_address
      t.date :application_start
      t.date :application_deadline
      t.date :notification_date
      t.date :program_start_date
      t.date :program_end_date
      t.date :checkback_date
      t.string :mail_from
      t.string :funded_by
      t.string :main_url
      t.string :department_url
      t.string :program_url
      t.references :grant, foreign_key: true

      t.timestamps
    end
  end
end
