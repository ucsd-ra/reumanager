class RemoveMailUrlFromGrants < ActiveRecord::Migration[5.1]
  def change
    remove_column :grants, :main_url, :string
  end
end
