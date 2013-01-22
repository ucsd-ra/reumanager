# create admins
u = User.new(:firstname => 'NSFREU', :lastname => 'Admin', :login => 'admin@reumanager.com', :email => 'admin@reumanager.com', :password => 'DemoApp', :password_confirmation => 'DemoApp', :role_id => 1, :dob => Time.now - 30.years, :street => '9500 Gilman Drive #0412', :city => 'La Jolla', :state => "CA", :zip => "92093-0412", :citizenship => "United States", :phone => "858-822-5947")
u.save
u.set_to_admin!

#
# INCOMPLETE STUDENT
#
# create sample students
s = User.new(:firstname => "James", :middlename => "", :lastname => "Madison", :email => "jmadison@reumanager.com", :login => "jmadison@reumanager.com", :dob => "1991-03-12 07:00:00", :street => "PO#50442    9450 Gilman Dr", :city => "La Jolla", :state => "CA", :zip => "92092", 
  :phone => "805-142-4415", :pstreet => "23152 Palminos Ave", :pcity => "Ventura", :pstate => "CA", :pzip => "93054", :pphone => nil, :citizenship => "United States", :cresidence => "", 
  :gender => "Male", :ethnicity => "Prefer not to respond", :race => "White", :disability => "No", :activated_at => nil, :submitted_at => nil, :rec_request_at => nil, :completed_at => nil, 
  :token => "37a6d51c6696091ca67e6b8e9beaaa0f3e0f6411", :token_created_at => "2011-03-01 21:09:23", :remember_token => nil, :remember_token_expires_at => nil, 
  :password => "DemoApp", :password_confirmation => "DemoApp" ,:status => "In Review", :role_id => 2, 
  :created_at => "2011-03-01 21:09:23", :updated_at => "2011-03-01 21:09:23", :emailed_rejection_letter_at => nil, :emailed_waitlist_letter_at => nil)
s.activate!
s.save_with_validation(false)

#
# SUBMITTED STUDENT
#
# create sample students
s = User.new(:firstname => "Abe", :middlename => "", :lastname => "Lincoln", :email => "alincoln@reumanager.com", :dob => "1992-04-12 07:00:00", :street => "PO#50442    9450 Gilman Dr", :city => "La Jolla", :state => "CA", :zip => "92092", 
  :phone => "805-541-2134", :pstreet => "1152 Natko Ave", :pcity => "Reallin", :pstate => "CA", :pzip => "95441", :pphone => nil, :citizenship => "United States", :cresidence => "", 
  :gender => "Male", :ethnicity => "Prefer not to respond", :race => "White", :disability => "No", :activated_at => nil, :submitted_at => nil, :rec_request_at => nil, :completed_at => nil, 
  :token => "37a6d51c6696091ca67e6b8e9beaaa0f3e0f6411", :token_created_at => "2011-03-01 21:09:23", :remember_token => nil, :remember_token_expires_at => nil, 
  :password => "DemoApp", :password_confirmation => "DemoApp" ,:status => "In Review", :role_id => 2, 
  :created_at => "2011-03-01 21:09:23", :updated_at => "2011-03-01 21:09:23", :submitted_at => "2011-03-02 21:09:23", :emailed_rejection_letter_at => nil, :emailed_waitlist_letter_at => nil )
s.submitted_at = "2011-03-02 21:09:23"

# create academic record
s.academic_record = AcademicRecord.new( :gpa => "4.0",
  :gpa_range => "4.0",
  :major => "Bioengineering",
  :college => "UC San Diego",
  :college_start => "2009-09-01 07:00:00".to_datetime,
  :college_level => 'Sophomore',
  :college_end => "2013-06-01 07:00:00".to_datetime,
  :transcript => File.new("#{RAILS_ROOT}/public/sample_transcript.jpg", "r"))

# create extra
s.extra = Extra.new(:awards => "Aliquam erat Volutpat 2012\r\n\r\nCurabitur at justo 2011-2012\r\n\r\nCurabitur pharetra 2011",
  :comp_skills => "Etiam ultrices adipiscing tellus, sed aliquam leo venenatis eu. Aenean lacinia tempor rutrum. Proin vel turpis est. Integer venenatis, elit eu sodales convallis, urna leo pellentesque dui, et pharetra tortor augue in enim.",
  :gpa_comments => "Duis risus nibh, molestie in rhoncus in, congue sed sapien. Cras non accumsan eros. Morbi vitae nibh sapien, sed blandit elit. Donec eu orci erat, non aliquam urna. Integer lobortis scelerisque dapibus. Aenean scelerisque nibh lectus. Aenean porta orci ut justo tempus nec tincidunt metus pharetra. Nulla ligula ligula, mattis at varius non, varius quis neque. Nunc dapibus consectetur elit vitae molestie. Praesent fringilla ornare ante, id dictum nunc facilisis non.",
  :lab_skills => "Aliquam erat volutpat. In vehicula nibh vel metus consequat ut vulputate velit congue. Donec mi enim, dictum id bibendum nec, ornare nec nibh. Curabitur at justo sed sapien fermentum feugiat. Maecenas egestas egestas lorem vel sollicitudin. Nunc aliquam iaculis turpis, a placerat nisl adipiscing eu. Cras semper, nunc in cursus elementum, eros enim interdum mauris, eget molestie lacus nisi nec diam. Curabitur nec elit enim, nec blandit turpis. Curabitur pharetra eleifend nisl. Pellentesque eget gravida enim. In hac habitasse platea dictumst.",
  :personal_statement => "Duis tincidunt bibendum mi pretium sagittis. Vestibulum at odio ipsum, sed laoreet erat. Aliquam ut ante eu lectus congue faucibus. In hac habitasse platea dictumst. Donec justo leo, aliquet vitae mollis in, iaculis a libero. Integer vitae ipsum id neque cursus aliquam. Donec eget massa quis tortor pellentesque facilisis. Etiam lacinia quam nec ligula lobortis porta. Mauris hendrerit tortor vel sem laoreet posuere. Sed posuere, leo eget sollicitudin tempus, leo diam euismod sem, id iaculis nisl dolor a magna. Nam sodales lacus quis ipsum mollis pulvinar. Etiam dictum ipsum a augue dictum ac suscipit elit elementum. Nullam quis leo vitae neque sollicitudin pharetra non vitae justo. Cras eu dui metus.",
  :learn => "NSF REU Website")

# create recommender
s.recommender = Recommender.new(:name => "James Monroe", :title => "Professor", :department => "Intergrative Biology", :college => "University of California, Berkeley", :phone => "510-442-1404", :email => "jmonroe@reumanager.com", :waive_rights => true)
s.activate!
s.save_with_validation(false)

#
# COMPLETE STUDENT
#
# create sample students
s = User.new(:firstname => "John", :middlename => "Quincy", :lastname => "Adams", :email => "jqadams@reumanager.com", :dob => "1991-07-12 07:00:00", :street => "PO#50442    9450 Gilman Dr", :city => "La Jolla", :state => "CA", :zip => "92092", 
  :phone => "805-163-4421", :pstreet => "6121 Lonhox Ave", :pcity => "Culver City", :pstate => "CA", :pzip => "90044", :pphone => nil, :citizenship => "United States", :cresidence => "", 
  :gender => "Male", :ethnicity => "Prefer not to respond", :race => "White", :disability => "No", :activated_at => nil, :submitted_at => nil, :rec_request_at => nil, :completed_at => nil, 
  :token => "37a6d51c6696091ca67e6b8e9beaaa0f3e0f6411", :token_created_at => "2011-03-01 21:09:23", :remember_token => nil, :remember_token_expires_at => nil, 
  :password => "DemoApp", :password_confirmation => "DemoApp" ,:status => "In Review", :role_id => 2, 
  :created_at => "2011-03-01 21:09:23", :updated_at => "2011-03-01 21:09:23", :emailed_rejection_letter_at => nil, :emailed_waitlist_letter_at => nil )
s.submitted_at = "2011-03-02 21:09:23"
s.completed_at = "2011-03-02 21:09:23"

# create academic record
s.academic_record = AcademicRecord.new( :gpa => "3.6",
  :gpa_range => "4.0",
  :major => "Biotechnology",
  :college => "UCLA",
  :college_start => "2009-09-01 07:00:00".to_datetime,
  :college_level => 'Sophomore',
  :college_end => "2013-06-01 07:00:00".to_datetime,
  :transcript => File.new("#{RAILS_ROOT}/public/sample_transcript.jpg", "r"))

# create extra
s.extra = Extra.new(:awards => "Aliquam erat Volutpat 2012\r\n\r\nCurabitur at justo 2011-2012\r\n\r\nCurabitur pharetra 2011",
  :comp_skills => "Aenean lacinia tempor rutrum. Proin vel turpis est. Integer venenatis, elit eu sodales convallis, urna leo pellentesque dui, et pharetra tortor augue in enim.",
  :gpa_comments => "Duis risus nibh, molestie in rhoncus in, congue sed sapien. Cras non accumsan eros. Morbi vitae nibh sapien, sed blandit elit. Donec eu orci erat, non aliquam urna. Integer lobortis scelerisque dapibus. Aenean scelerisque nibh lectus. Aenean porta orci ut justo tempus nec tincidunt metus pharetra. Nulla ligula ligula, mattis at varius non, varius quis neque. Nunc dapibus consectetur elit vitae molestie. Praesent fringilla ornare ante, id dictum nunc facilisis non.",
  :lab_skills => "Aliquam erat volutpat. In vehicula nibh vel metus consequat ut vulputate velit congue. Donec mi enim, dictum id bibendum nec, ornare nec nibh. Curabitur at justo sed sapien fermentum feugiat. Maecenas egestas egestas lorem vel sollicitudin. Nunc aliquam iaculis turpis, a placerat nisl adipiscing eu. Cras semper, nunc in cursus elementum, eros enim interdum mauris, eget molestie lacus nisi nec diam. Curabitur nec elit enim, nec blandit turpis. Curabitur pharetra eleifend nisl. Pellentesque eget gravida enim. In hac habitasse platea dictumst.",
  :personal_statement => "Duis tincidunt bibendum mi pretium sagittis. Vestibulum at odio ipsum, sed laoreet erat. Aliquam ut ante eu lectus congue faucibus. In hac habitasse platea dictumst. Donec justo leo, aliquet vitae mollis in, iaculis a libero. Integer vitae ipsum id neque cursus aliquam. Donec eget massa quis tortor pellentesque facilisis. Etiam lacinia quam nec ligula lobortis porta. Mauris hendrerit tortor vel sem laoreet posuere. Sed posuere, leo eget sollicitudin tempus, leo diam euismod sem, id iaculis nisl dolor a magna. Nam sodales lacus quis ipsum mollis pulvinar. Etiam dictum ipsum a augue dictum ac suscipit elit elementum. Nullam quis leo vitae neque sollicitudin pharetra non vitae justo. Cras eu dui metus. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo",
  :learn => "NSF REU Website")

# create recommender
s.recommender = Recommender.new(:name => "Martin Van Buren", :title => "Professor", :department => "Intergrative Biology", :college => "University of California, Berkeley", :phone => "510-448-8404", :email => "mvburen@reumanager.com", :waive_rights => true)
s.activate!
s.save_with_validation(false)

# create recommendation
s.recommendation = Recommendation.new( :known_student => "<1 year", :know_capacity => "Undergrad in one course", :rating => "Top 10%", :undergrad_inst => "No",
  :faculty_comment => "To whom it may concern:\r\n\r\n\tSed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. \r\n\tNeque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.\r\n\r\nSincerely,\r\n\r\nMartin Van Buren Ph.D.\r\nProfessor, Biomedical Engineering\r\r\n")
s.save

#
# WITHDRAWN STUDENT
#
# create sample students
s = User.new( :firstname => "Theodore", :middlename => "", :lastname => "Roosevelt", :email => "troosevelt@reumanager.com", :dob => "1991-07-12 07:00:00", :street => "PO#50442    9450 Gilman Dr", :city => "La Jolla", :state => "CA", :zip => "92092", 
  :phone => "805-613-4419", :pstreet => "952 Plum Ave", :pcity => "Ventura", :pstate => "CA", :pzip => "93004", :pphone => nil, :citizenship => "United States", :cresidence => "", 
  :gender => "Male", :ethnicity => "Prefer not to respond", :race => "White", :disability => "No", :activated_at => nil, :submitted_at => nil, :rec_request_at => nil, :completed_at => nil, 
  :token => "37a6d51c6696091ca67e6b8e9beaaa0f3e0f6411", :token_created_at => "2011-03-01 21:09:23", :remember_token => nil, :remember_token_expires_at => nil, 
  :password => "nsfreudemo", :password_confirmation => "nsfreudemo" , :status => "Withdrawn", :role_id => 2, 
  :created_at => "2011-03-01 21:09:23", :updated_at => "2011-03-01 21:09:23", :emailed_rejection_letter_at => nil, :emailed_waitlist_letter_at => nil )
s.status = 'Withdrawn'

# create academic record
s.academic_record = AcademicRecord.new( :gpa => "3.2",
  :gpa_range => "4.0",
  :major => "Biotechnology/Economics",
  :college => "UC, Berkeley",
  :college_start => "2009-09-01 07:00:00".to_datetime,
  :college_level => 'Sophomore',
  :college_end => "2013-06-01 07:00:00".to_datetime,
  :transcript => File.new("#{RAILS_ROOT}/public/sample_transcript.jpg", "r"))

s.activate!
s.save_with_validation(false)
