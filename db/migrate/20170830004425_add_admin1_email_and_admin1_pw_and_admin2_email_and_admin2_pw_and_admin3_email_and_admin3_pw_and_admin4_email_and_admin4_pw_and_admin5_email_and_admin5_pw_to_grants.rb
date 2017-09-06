class AddAdmin1EmailAndAdmin1PwAndAdmin2EmailAndAdmin2PwAndAdmin3EmailAndAdmin3PwAndAdmin4EmailAndAdmin4PwAndAdmin5EmailAndAdmin5PwToGrants < ActiveRecord::Migration[5.1]
  def change
    add_column :grants, :admin1_email, :string
    add_column :grants, :admin1_pw, :string
    add_column :grants, :admin2_email, :string
    add_column :grants, :admin2_pw, :string
    add_column :grants, :admin3_email, :string
    add_column :grants, :admin3_pw, :string
    add_column :grants, :admin4_email, :string
    add_column :grants, :admin4_pw, :string
    add_column :grants, :admin5_email, :string
    add_column :grants, :admin5_pw, :string
  end
end
