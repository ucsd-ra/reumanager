# create admins
u = User.new(:firstname => 'NSFREU', :lastname => 'Admin', :login => 'nsfreu@be.ucsd.edu', :email => 'nsfreu@be.ucsd.edu', :password => 'DemoApp', :password_confirmation => 'DemoApp', :role_id => 1, :dob => Time.now - 30.years, :street => '9500 Gilman Drive #0412', :city => 'La Jolla', :state => "CA", :zip => "92093-0412", :citizenship => "United States", :phone => "858-822-5947")
u.save
u.set_to_admin!

#
# INCOMPLETE STUDENT
#
# create sample students
s = User.new(:firstname => "Abe", :middlename => "", :lastname => "Lincoln", :email => "alincoln@be.ucsd.edu", :dob => "1991-07-12 07:00:00", :street => "PO#50442    9450 Gilman Dr", :city => "La Jolla", :state => "CA", :zip => "92092", 
  :phone => "805-663-4445", :pstreet => "1212 Orange Ave", :pcity => "Ventura", :pstate => "CA", :pzip => "93004", :pphone => nil, :citizenship => "United States", :cresidence => "", 
  :gender => "Male", :ethnicity => "Prefer not to respond", :race => "White", :disability => "No", :activated_at => nil, :submitted_at => nil, :rec_request_at => nil, :completed_at => nil, 
  :token => "37a6d51c6696091ca67e6b8e9beaaa0f3e0f6411", :token_created_at => "2011-03-01 21:09:23", :remember_token => nil, :remember_token_expires_at => nil, 
  :password => "nsfreudemo", :password_confirmation => "nsfreudemo" ,:status => "In Review", :role_id => 2, 
  :created_at => "2011-03-01 21:09:23", :updated_at => "2011-03-01 21:09:23", :emailed_rejection_letter_at => nil, :emailed_waitlist_letter_at => nil)
s.save

#
# SUBMITTED STUDENT
#
# create sample students
s = User.new(:firstname => "John", :middlename => "Quincy", :lastname => "Adams", :email => "jqadams@be.ucsd.edu", :dob => "1991-07-12 07:00:00", :street => "PO#50442\n 9450 Gilman Dr", :city => "La Jolla", :state => "CA", :zip => "92092", 
  :phone => "805-663-4445", :pstreet => "1132 Orange Ave", :pcity => "Ventura", :pstate => "CA", :pzip => "93004", :pphone => nil, :citizenship => "United States", :cresidence => "", 
  :gender => "Male", :ethnicity => "Prefer not to respond", :race => "White", :disability => "No", :activated_at => nil, :submitted_at => nil, :rec_request_at => nil, :completed_at => nil, 
  :token => "37a6d51c6696091ca67e6b8e9beaaa0f3e0f6411", :token_created_at => "2011-03-01 21:09:23", :remember_token => nil, :remember_token_expires_at => nil, 
  :password => "nsfreudemo", :password_confirmation => "nsfreudemo" ,:status => "In Review", :role_id => 2, 
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
  :transcript_content_type => 'application/pdf',
  :transcript_file_size => "193576",
  :transcript_updated_at => '2011-03-02 04:51:21'.to_datetime,
  :transcript_file_name => "transcript.pdf")

# create extra
s.extra = Extra.new(:awards => "Super Science Scholar 2010 to 2011\r\n\r\nDean’s List 6 Semesters, 2007 to present\r\n\r\nSan Francisco Heritage Scholarship, Fall 2008, Fall 2009, Fall 2010",
  :comp_skills => "Proficient in Matlab, Aspen, Word, Excel, PowerPoint, Access, Project, Adobe Acrobat, C3 Suites.",
  :gpa_comments => "I believe my GPA accurately reflects my abilities in some cases, and does not in others. I believe that it could be better, but unfortunately I cannot dedicate my full energy to my academics.  I have to work in order to support myself.  Therefore I cannot dedicate all my time to studies.",
  :lab_skills => "buffer preparation, western blotting, genotyping, cloning, ELISA assays",
  :personal_statement => "I am interested in the REU in Regenerative Medicine, Multi-Scale Bioengineering, and Systems Biology program because I want to expand my research experience. The invaluable opportunity to participate in the UCSD NSF REU Program would allow me to feed my passion.  I will benefit from the intense research focus, allowing me to gain more experience and develop professionally. The Program will also enrich my undergraduate experience and prepare me for the academic rigors.",
  :learn => "NSF REU Website")

# create recommender
s.recommender = Recommender.new(:name => "James Monroe", :title => "Professor", :department => "Intergrative Biology", :college => "University of California, Berkeley", :phone => "510-448-8404", :email => "jmonroe@be.ucsd.edu", :waive_rights => true)
s.save

#
# COMPLETE STUDENT
#
# create sample students
s = User.new(:firstname => "John", :middlename => "Quincy", :lastname => "Adams", :email => "jqadams@be.ucsd.edu", :dob => "1991-07-12 07:00:00", :street => "PO#50442\n 9450 Gilman Dr", :city => "La Jolla", :state => "CA", :zip => "92092", 
  :phone => "805-663-4445", :pstreet => "2522 Orange Ave", :pcity => "Ventura", :pstate => "CA", :pzip => "93004", :pphone => nil, :citizenship => "United States", :cresidence => "", 
  :gender => "Male", :ethnicity => "Prefer not to respond", :race => "White", :disability => "No", :activated_at => nil, :submitted_at => nil, :rec_request_at => nil, :completed_at => nil, 
  :token => "37a6d51c6696091ca67e6b8e9beaaa0f3e0f6411", :token_created_at => "2011-03-01 21:09:23", :remember_token => nil, :remember_token_expires_at => nil, 
  :password => "nsfreudemo", :password_confirmation => "nsfreudemo" ,:status => "In Review", :role_id => 2, 
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
  :transcript_content_type => 'application/pdf',
  :transcript_file_size => "193576",
  :transcript_updated_at => '2011-03-02 04:51:21'.to_datetime,
  :transcript_file_name => "transcript.pdf")

# create extra
s.extra = Extra.new(:awards => "Super Science Scholar 2010 to 2011\r\n\r\nDean’s List 6 Semesters, 2007 to present\r\n\r\nSan Francisco Heritage Scholarship, Fall 2008, Fall 2009, 2010",
  :comp_skills => "Proficient in Matlab, Aspen, Word, Excel, PowerPoint, Access, Project, Adobe Acrobat, C3 Suites.",
  :gpa_comments => "I believe my GPA accurately reflects my abilities in some cases, and does not in others. I believe that it could be better, but unfortunately I cannot dedicate my full energy to my academics.  I have to work in order to support myself.  Therefore I cannot dedicate all my time to studies.",
  :lab_skills => "buffer preparation, western blotting, genotyping, cloning, ELISA assays.",
  :personal_statement => "I am interested in the REU in Regenerative Medicine, Multi-Scale Bioengineering, and Systems Biology program because I want to expand my research experience. The invaluable opportunity to participate in the UCSD NSF REU Program would allow me to feed my passion.  I will benefit from the intense research focus, allowing me to gain more experience and develop professionally. The Program will also enrich my undergraduate experience and prepare me for the academic rigors.",
  :learn => "NSF REU Website")

# create recommender
s.recommender = Recommender.new(:name => "Martin Van Buren", :title => "Professor", :department => "Intergrative Biology", :college => "University of California, Berkeley", :phone => "510-448-0000", :email => "mvburen@be.ucsd.edu", :waive_rights => true)
s.save

# create recommendation
s.recommendation = Recommendation.new( :known_student => "<1 year", :know_capacity => "Undergrad in one course", :rating => "Top 10%", :undergrad_inst => "No",
  :faculty_comment => "To whom it may concern:\r\n\r\n\tI write to recommend John Quincy Adams for a summer research internship.  I have known John since fall semester, 2010, as a student in my biomedical engineering course, in which he earned a grade of A- and ranked at about the middle among the 132 students.  Students write three critiques of published papers, four exams and quantitative homework problems.  It is the only course outside the medical school curriculum.\r\n\tJohn’s overall performance in all of his classes would rank him among the top 15% of students in engineering.  He is earning a major in biomedical engineering and doing very well.  He is an engaging student, disciplined and intelligent.  He works hard, is organized, honest and imaginative.  John asks thoughtful questions about both his classroom work and his plans for the future.  \r\n\tI believe you will find that John will make significant contributions to your program and I recommend him most enthusiastically.  He has demonstrated the highest intellectual rigor and a consistent motivation for excellence in his course work.  I would be happy to respond to questions.\r\n\r\nSincerely,\r\n\r\nMartin Van Buren Ph.D.\r\nProfessor, Biomedical Engineering\r\nProfessor Bioengineering\r\n")
s.save

#
# WITHDRAWN STUDENT
#
# create sample students
s = User.new(:firstname => "John", :middlename => "Quincy", :lastname => "Adams", :email => "jqadams@be.ucsd.edu", :dob => "1991-07-12 07:00:00", :street => "PO#50442\n 9450 Gilman Dr", :city => "La Jolla", :state => "CA", :zip => "92092", 
  :phone => "805-663-0000", :pstreet => "1221 Orange Ave", :pcity => "Ventura", :pstate => "CA", :pzip => "93004", :pphone => nil, :citizenship => "United States", :cresidence => "", 
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
  :transcript_content_type => 'application/pdf',
  :transcript_file_size => "193576",
  :transcript_updated_at => '2011-03-02 04:51:21'.to_datetime,
  :transcript_file_name => "transcript.pdf")
s.save