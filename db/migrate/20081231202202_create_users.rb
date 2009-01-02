class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                :string, :limit => 100
      t.column :firstname,            :string, :limit => 100, :default => '', :null => true
      t.column :middlename,           :string, :limit => 100, :default => '', :null => true
      t.column :lastname,             :string, :limit => 100, :default => '', :null => true
      t.column :email,                :string, :limit => 100
      t.column :dob,                  :datetime
      t.column :street,               :string
      t.column :city,                 :string
      t.column :state,                :string
      t.column :zip,                  :string
      t.column :phone,                :string
      t.column :pstreet,              :string
      t.column :pcity,                :string
      t.column :pstate,               :string
      t.column :pzip,                 :string
      t.column :pphone,               :string
      t.column :email,                :string
      t.column :citizenship,          :string
      t.column :cresidence,           :string
      t.column :gender,               :string
      t.column :ethnicity,            :string
      t.column :race,                 :string
      t.column :disability,           :string
      t.column :submit_date,          :datetime      
      t.column :rec_request,          :datetime
      t.column :completed,            :datetime
      t.column :token,                :string
      t.column :remember_token,            :string, :limit => 40
      t.column :remember_token_expires_at, :datetime
      t.column :crypted_password,     :string, :limit => 40
      t.column :salt,                 :string, :limit => 40
      t.column :created_at,           :datetime
      t.column :updated_at,           :datetime
    end
    add_index :users, :login, :unique => true
  end

  def self.down
    drop_table "users"
  end
end
