class RemoveProgramDescriptionFromGrants < ActiveRecord::Migration[5.1]
  def change
    remove_column :grants, :program_description, :string
  end
end
