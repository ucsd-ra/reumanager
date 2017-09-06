class AddDpmtPostAndMailFromAndFundingAndMainUrlAndDpmtUrlAndProgramUrlToGrants < ActiveRecord::Migration[5.1]
  def change
    add_column :grants, :dpmt_post, :string
    add_column :grants, :mail_from, :string
    add_column :grants, :main_url, :string
    add_column :grants, :dpmt_url, :string
    add_column :grants, :program_url, :string
  end
end
