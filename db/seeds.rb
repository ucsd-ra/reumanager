# create admins
u = User.new(:firstname => 'SURF REU', :lastname => 'Admin', :login => 'jgrevich@ucsd.edu', :email => 'jgrevich@ucsd.edu', :password => 'DemfsdfdsoApp', :password_confirmation => 'DemfsdfdsoApp', :role_id => 1, :dob => Time.now - 30.years, :street => '9500 Gilman Drive #0412', :city => 'La Jolla', :state => "CA", :zip => "92093-0412", :citizenship => "United States", :phone => "858-822-5947")
u.save
u.set_to_admin!

# create admins
u = User.new(:firstname => 'Jane', :lastname => 'Teranes', :login => 'jteranes@ucsd.edu', :email => 'jteranes@ucsd.edu', :password => 'dsfDemoApsdfdsp', :password_confirmation => 'dsfDemoApsdfdsp', :role_id => 1, :dob => Time.now - 30.years, :street => '9500 Gilman Drive #0412', :city => 'La Jolla', :state => "CA", :zip => "92093-0412", :citizenship => "United States", :phone => "858-822-5947")
u.save
u.set_to_admin!

# create admins
u = User.new(:firstname => 'Eric', :lastname => 'Simms', :login => 'esimms@ucsd.edu', :email => 'esimms@ucsd.edu', :password => 'DemosdfdsfsApp', :password_confirmation => 'DemosdfdsfsApp', :role_id => 1, :dob => Time.now - 30.years, :street => '9500 Gilman Drive #0412', :city => 'La Jolla', :state => "CA", :zip => "92093-0412", :citizenship => "United States", :phone => "858-822-5947")
u.save
u.set_to_admin!

