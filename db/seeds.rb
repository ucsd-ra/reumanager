# create admins
u = User.new(:firstname => 'NSFREU', :lastname => 'Admin', :login => 'admin@reumanager.com', :email => 'admin@reumanager.com', :password => '4saihung', :password_confirmation => '4saihung', :role_id => 1, :dob => Time.now - 30.years, :street => '9500 Gilman Drive #0412', :city => 'La Jolla', :state => "CA", :zip => "92093-0412", :citizenship => "United States", :phone => "858-822-5947")
u.save
u.set_to_admin!

u = User.new(:firstname => 'Elliot', :lastname => 'Douglas', :login => 'edoug@mse.ufl.edu', :email => 'edoug@mse.ufl.edu', :password => 'Change-Me-Please', :password_confirmation => 'Change-Me-Please', :role_id => 1, :dob => Time.now - 30.years, :street => '9500 Gilman Drive #0412', :city => 'La Jolla', :state => "CA", :zip => "92093-0412", :citizenship => "United States", :phone => "858-822-5947")
u.save
u.set_to_admin!