class CreateAdminAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_accounts do |t|
      t.string :admin1_email
      t.string :admin1_pwd
      t.string :admin2_email
      t.string :admin2_pwd
      t.string :admin3_email
      t.string :admin3_pwd
      t.string :admin4_email
      t.string :admin4_pwd
      t.string :admin5_email
      t.string :admin5_pwd
      t.references :grant, foreign_key: true

      t.timestamps
    end
  end
end
