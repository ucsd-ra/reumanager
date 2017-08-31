class AddContactEmailAndContactPasswordToGrants < ActiveRecord::Migration[5.1]
  def change
    add_column :grants, :contact_email, :string
    add_column :grants, :contact_password, :string
  end
end
