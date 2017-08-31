class RemoveAdmin1EmailAndAdmin1PwAndAdmin2EmailAndAdmin2PwAndAdmin3EmailAndAdmin3PwAndAdmin4EmailAndAdmin4PwAndAdmin5EmailAndAdmin5PwFromGrants < ActiveRecord::Migration[5.1]
  def change
    remove_column :grants, :admin1_email, :string
    remove_column :grants, :admin1_pw, :string
    remove_column :grants, :admin2_email, :string
    remove_column :grants, :admin2_pw, :string
    remove_column :grants, :admin3_email, :string
    remove_column :grants, :admin3_pw, :string
    remove_column :grants, :admin4_email, :string
    remove_column :grants, :admin4_pw, :string
    remove_column :grants, :admin5_email, :string
    remove_column :grants, :admin5_pw, :string

    remove_column :grants, :institution, :string
    remove_column :grants, :department, :string

    remove_column :grants, :app_start, :date
    remove_column :grants, :app_deadline, :date
    remove_column :grants, :notification_date, :date
    remove_column :grants, :program_start, :date
    remove_column :grants, :program_end, :date    
    remove_column :grants, :checkback_date, :date

    remove_column :grants, :dpmt_post, :string
    remove_column :grants, :mail_from, :string
    remove_column :grants, :dpmt_url, :string
    remove_column :grants, :program_url, :string

    remove_column :grants, :gen_description, :text
    remove_column :grants, :highlights, :text
    remove_column :grants, :eligibility, :text
    

  end
end
