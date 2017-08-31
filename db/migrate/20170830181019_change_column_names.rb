class ChangeColumnNames < ActiveRecord::Migration[5.1]
  def change

  	rename_column :grants, :notification_start, :notification_date
  	rename_column :grants, :gen_descr, :gen_description
  end
end
