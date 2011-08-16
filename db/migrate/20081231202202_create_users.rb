class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                     :string, :limit => 100
      t.column :firstname,                 :string, :limit => 100, :default => '', :null => true
      t.column :middlename,                :string, :limit => 100, :default => '', :null => true
      t.column :lastname,                  :string, :limit => 100, :default => '', :null => true
      t.column :email,                     :string, :limit => 100
      t.column :dob,                       :datetime
      t.column :street,                    :string
      t.column :city,                      :string
      t.column :state,                     :string
      t.column :zip,                       :string
      t.column :phone,                     :string
      t.column :pstreet,                   :string
      t.column :pcity,                     :string
      t.column :pstate,                    :string
      t.column :pzip,                      :string
      t.column :pphone,                    :string
      t.column :citizenship,               :string
      t.column :cresidence,                :string
      t.column :gender,                    :string
      t.column :ethnicity,                 :string
      t.column :race,                      :string
      t.column :disability,                :string
      t.column :activated_at,              :datetime
      t.column :submitted_at,              :datetime
      t.column :rec_request_at,            :datetime
      t.column :completed_at,              :datetime
      t.column :token,                     :string
      t.column :token_created_at,           :datetime
      t.column :remember_token,            :string, :limit => 40
      t.column :remember_token_expires_at, :datetime
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :status,                    :string, :default => "In Review"
      t.column :role_id,                   :integer, :default => 2
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
    end
    add_index :users, :login, :unique => true
    @u = User.new(:firstname => 'BE', :lastname => 'Admin', :login => 'jgrevich@ucsd.edu', :email => 'jgrevich@ucsd.edu', :password => '4saihung', :password_confirmation => '4saihung', :role_id => 1, :dob => Time.now - 30.years, :street => '9500 Gilman Drive #0412', :city => 'La Jolla', :state => "CA", :zip => "92093-0412", :citizenship => "United States", :phone => "858-822-5947" )
    @u.save
    @u.set_to_admin!
    @u = User.new(:firstname => 'Melissa', :lastname => 'Micou', :login => 'mmicou@ucsd.edu', :email => 'mmicou@ucsd.edu', :password => '4saihung', :password_confirmation => '4saihung', :role_id => 1, :dob => Time.now - 30.years, :street => '9500 Gilman Drive #0412', :city => 'La Jolla', :state => "CA", :zip => "92093-0412", :citizenship => "United States", :phone => "858-822-5947")
    @u.save
    @u.set_to_admin!
    @u = User.new(:firstname => 'NSFREU', :lastname => 'Admin', :login => 'nsfreu@be.ucsd.edu', :email => 'nsfreu@be.ucsd.edu', :password => 'DemoApp', :password_confirmation => 'DemoApp', :role_id => 1, :dob => Time.now - 30.years, :street => '9500 Gilman Drive #0412', :city => 'La Jolla', :state => "CA", :zip => "92093-0412", :citizenship => "United States", :phone => "858-822-5947")
    @u.save
    @u.set_to_admin!
  end

  def self.down
    drop_table "users"
  end
end
