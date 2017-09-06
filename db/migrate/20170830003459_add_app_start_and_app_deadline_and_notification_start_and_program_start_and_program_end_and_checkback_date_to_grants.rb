class AddAppStartAndAppDeadlineAndNotificationStartAndProgramStartAndProgramEndAndCheckbackDateToGrants < ActiveRecord::Migration[5.1]
  def change
    add_column :grants, :app_start, :date
    add_column :grants, :app_deadline, :date
    add_column :grants, :notification_start, :date
    add_column :grants, :program_start, :date
    add_column :grants, :program_end, :date
    add_column :grants, :checkback_date, :date
  end
end
