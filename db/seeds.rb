# create admins
u = User.new(:firstname => 'SURF REU', :lastname => 'Admin', :login => 'rob@notch8.com', :email => 'rob@notch8.com', :password => 'DemfsdfdsoApp', :password_confirmation => 'DemfsdfdsoApp', :role_id => 1, :dob => Time.now - 30.years, :street => '9500 Gilman Drive #0412', :city => 'La Jolla', :state => "CA", :zip => "92093-0412", :citizenship => "United States", :phone => "858-822-5947")
u.save
u.set_to_admin!

u = User.new(:firstname => 'Melissa', :lastname => 'Micou', :login => 'mmicou@ucsd.edu', :email => 'mmicou@ucsd.edu', :password => 'DemfsdfdsoApp', :password_confirmation => 'DemfsdfdsoApp', :role_id => 1, :dob => Time.now - 30.years, :street => '9500 Gilman Drive #0412', :city => 'La Jolla', :state => "CA", :zip => "92093-0412", :citizenship => "United States", :phone => "858-822-5947")
u.save
u.set_to_admin!


# create admins
u = User.new(:firstname => 'Jane', :lastname => 'Teranes', :login => 'jteranes@ucsd.edu', :email => 'jteranes@ucsd.edu', :password => 'DemfsdfdsoApp', :password_confirmation => 'DemfsdfdsoApp', :role_id => 1, :dob => Time.now - 30.years, :street => '9500 Gilman Drive #0412', :city => 'La Jolla', :state => "CA", :zip => "92093-0412", :citizenship => "United States", :phone => "858-822-5947")
u.save
u.set_to_admin!

# create admins
u = User.new(:firstname => 'Josh', :lastname => 'Reeves', :login => 'jdreeves@ucsd.edu', :email => 'jdreeves@ucsd.edu', :password => 'DemfsdfdsoApp', :password_confirmation => 'DemfsdfdsoApp', :role_id => 1, :dob => Time.now - 30.years, :street => '9500 Gilman Drive #0412', :city => 'La Jolla', :state => "CA", :zip => "92093-0412", :citizenship => "United States", :phone => "858-822-5947")
u.save
u.set_to_admin!

u = User.new(:firstname => 'J3', :lastname => 'Taylor', :login => 'j3taylor@ucsd.edu', :email => 'j3taylor@ucsd.edu', :password => 'DemfsdfdsoApp', :password_confirmation => 'DemfsdfdsoApp', :role_id => 1, :dob => Time.now - 30.years, :street => '9500 Gilman Drive #0412', :city => 'La Jolla', :state => "CA", :zip => "92093-0412", :citizenship => "United States", :phone => "858-822-5947")
u.save
u.set_to_admin!
