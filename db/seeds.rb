# create admins
u = User.new(:firstname => 'Justin', :lastname => 'Grevich', :login => 'jgrevich@ucsd.edu', :email => 'jgrevich@ucsd.edu', :password => '4saihung', :password_confirmation => '4saihung', :role_id => 1, :dob => Time.now - 30.years, :street => '9500 Gilman Drive #0412', :city => 'La Jolla', :state => "CA", :zip => "92093-0412", :citizenship => "United States", :phone => "858-822-5947")
u.save
u.set_to_admin!


# create admins
u = User.new(:firstname => 'Melissa', :lastname => 'Micou', :login => 'mmicou@ucsd.edu', :email => 'mmicou@ucsd.edu', :password => 'ChangeMe', :password_confirmation => 'ChangeMe', :role_id => 1, :dob => Time.now - 30.years, :street => '9500 Gilman Drive #0412', :city => 'La Jolla', :state => "CA", :zip => "92093-0412", :citizenship => "United States", :phone => "858-822-5947")
u.save
u.set_to_admin!
