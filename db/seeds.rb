# create admins
u = User.new(:firstname => 'NSFREU', :lastname => 'Admin', :login => 'nsfreu@be.ucsd.edu', :email => 'nsfreu@be.ucsd.edu', :password => 'DemoApp', :password_confirmation => 'DemoApp', :role_id => 1, :dob => Time.now - 30.years, :street => '9500 Gilman Drive #0412', :city => 'La Jolla', :state => "CA", :zip => "92093-0412", :citizenship => "United States", :phone => "858-822-5947")
u.save
u.set_to_admin!

#
# INCOMPLETE STUDENT
#
# create sample students
s = User.new(:firstname => "Abe", :middlename => "", :lastname => "Lincoln", :email => "alincoln@be.ucsd.edu", :dob => "1991-07-12 07:00:00", :street => "PO#50442    9450 Gilman Dr", :city => "La Jolla", :state => "CA", :zip => "92092", 
  :phone => "805-663-4445", :pstreet => "252 Plum Ave", :pcity => "Ventura", :pstate => "CA", :pzip => "93004", :pphone => nil, :citizenship => "United States", :cresidence => "", 
  :gender => "Male", :ethnicity => "Prefer not to respond", :race => "White", :disability => "No", :activated_at => nil, :submitted_at => nil, :rec_request_at => nil, :completed_at => nil, 
  :token => "37a6d51c6696091ca67e6b8e9beaaa0f3e0f6411", :token_created_at => "2011-03-01 21:09:23", :remember_token => nil, :remember_token_expires_at => nil, 
  :password => "nsfreudemo", :password_confirmation => "nsfreudemo" ,:status => "In Review", :role_id => 2, 
  :created_at => "2011-03-01 21:09:23", :updated_at => "2011-03-01 21:09:23", :emailed_rejection_letter_at => nil, :emailed_waitlist_letter_at => nil)
s.save

#
# SUBMITTED STUDENT
#
# create sample students
s = User.new(:firstname => "James", :middlename => "", :lastname => "Madison", :email => "jmadison@be.ucsd.edu", :dob => "1991-07-12 07:00:00", :street => "PO#50442    9450 Gilman Dr", :city => "La Jolla", :state => "CA", :zip => "92092", 
  :phone => "805-663-4445", :pstreet => "252 Plum Ave", :pcity => "Ventura", :pstate => "CA", :pzip => "93004", :pphone => nil, :citizenship => "United States", :cresidence => "", 
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
  :transcript_file_name => "UCSDTranscript.pdf")

# create extra
s.extra = Extra.new(:awards => "Ronald E. McNair Scholar 2010 to 2011\r\n\r\nDean’s List 6 Semesters, 2007 to present\r\n\r\nAtrisco Heritage Scholarship, Fall 2008, Fall 2009, Fall 2010",
  :comp_skills => "Proficient in Matlab, Aspen, Word, Excel, PowerPoint, Access, Project, Adobe Acrobat, C3 Suites.",
  :gpa_comments => "I feel my GPA is a relatively fair representation of my academic abilities.  I believe that it could be better, but unfortunately I cannot dedicate my full energy to my academics.  I have to work in order to support myself.  Therefore I cannot dedicate all my time to studies.  Even though I have some time restrictions with my academics, I feel that it makes me truly appreciate of my education and the journey I have to take in order to receive it.",
  :lab_skills => "Unfortunately I am still fairly novice with laboratory skills.  I have run gas chromatography, reflux process, solution preparation, and absorption spectroscopy through various labs in my curriculum.  I have obtained training on safe chemical handling and storage, and cryogens.  As I always, I maintain an eagerness for learning efficient lab techniques.  My lab skills are scarce but the research experience I do have is as follows: My first research experience was working part time in the summer of 2010 at the Advanced Materials Laboratory.  The research I worked on was generating nano-particles for protocell drug delivery systems that targeted diseases such as cancer.  The goal was to determine an appropriate recipe and separation process that produced a certain range of silica nano-particles consisting of a range of certain pore size. I spent my time assisting in the creation of a particle generator, carrying out the creation of the nanoparticles, and trying to learn mass transfer for mathematical modeling and particle size prediction.  Currently I am doing research in a lab at UNM’s Center for Biomedical Engineering.  The area of research is low-cost diagnostics and multiplex lateral flow assays.  I am working to disprove chromatographic sieving on semi-quantitative test strips, by proving homogeneity of an analyte throughout the test strip.",
  :personal_statement => "Participating in the UCSD NSF program will enhance my graduate plans and my career goals.  I plan on applying to some of the top graduate schools for bioengineering and having a high GPA is not enough to guarantee acceptance. I want to be the best candidate I can be and for that reason, I desire to obtain as much research experience as I can as an undergrad. I want to further develop a research/problem solving mentality and work on my shortfalls.  Even though I have some experience, I still feel like a novice when it comes to doing research. I really want to become versed in common analysis methods, lab procedures, and methodology development.  I feel my other shortfall is detail searching.  When I do research I spend a lot of time trying to understand every detail and aspect of it. This is useful in fully understanding applications and mechanics, but sometimes it hinders research progress and is time costly.  I would like to find the appropriate balance of research progress and detail searching. I am trying to obtain as much research as I can so that I may have many skills and tools for when I apply for graduate school. This program will give me the opportunity to learn the necessary skills to work efficiency and productively in my career.  Furthermore, I know the program with provide me with a stimulating and challenging atmosphere that will push me to develop into a better researcher.",
  :learn => "NSF REU Website")

# create recommender
s.recommender = Recommender.new(:name => "James Monroe", :title => "Professor", :department => "Intergrative Biology", :college => "University of California, Berkeley", :phone => "510-448-8404", :email => "jmonroe@be.ucsd.edu", :waive_rights => true)
s.save

#
# COMPLETE STUDENT
#
# create sample students
s = User.new(:firstname => "John", :middlename => "Quincy", :lastname => "Adams", :email => "jqadams@be.ucsd.edu", :dob => "1991-07-12 07:00:00", :street => "PO#50442    9450 Gilman Dr", :city => "La Jolla", :state => "CA", :zip => "92092", 
  :phone => "805-663-4445", :pstreet => "252 Plum Ave", :pcity => "Ventura", :pstate => "CA", :pzip => "93004", :pphone => nil, :citizenship => "United States", :cresidence => "", 
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
  :transcript_file_name => "UCSDTranscript.pdf")

# create extra
s.extra = Extra.new(:awards => "Ronald E. McNair Scholar 2010 to 2011\r\n\r\nDean’s List 6 Semesters, 2007 to present\r\n\r\nAtrisco Heritage Scholarship, Fall 2008, Fall 2009, Fall 2010",
  :comp_skills => "Proficient in Matlab, Aspen, Word, Excel, PowerPoint, Access, Project, Adobe Acrobat, C3 Suites.",
  :gpa_comments => "I feel my GPA is a relatively fair representation of my academic abilities.  I believe that it could be better, but unfortunately I cannot dedicate my full energy to my academics.  I have to work in order to support myself.  Therefore I cannot dedicate all my time to studies.  Even though I have some time restrictions with my academics, I feel that it makes me truly appreciate of my education and the journey I have to take in order to receive it.",
  :lab_skills => "Unfortunately I am still fairly novice with laboratory skills.  I have run gas chromatography, reflux process, solution preparation, and absorption spectroscopy through various labs in my curriculum.  I have obtained training on safe chemical handling and storage, and cryogens.  As I always, I maintain an eagerness for learning efficient lab techniques.  My lab skills are scarce but the research experience I do have is as follows: My first research experience was working part time in the summer of 2010 at the Advanced Materials Laboratory.  The research I worked on was generating nano-particles for protocell drug delivery systems that targeted diseases such as cancer.  The goal was to determine an appropriate recipe and separation process that produced a certain range of silica nano-particles consisting of a range of certain pore size. I spent my time assisting in the creation of a particle generator, carrying out the creation of the nanoparticles, and trying to learn mass transfer for mathematical modeling and particle size prediction.  Currently I am doing research in a lab at UNM’s Center for Biomedical Engineering.  The area of research is low-cost diagnostics and multiplex lateral flow assays.  I am working to disprove chromatographic sieving on semi-quantitative test strips, by proving homogeneity of an analyte throughout the test strip.",
  :personal_statement => "Participating in the UCSD NSF program will enhance my graduate plans and my career goals.  I plan on applying to some of the top graduate schools for bioengineering and having a high GPA is not enough to guarantee acceptance. I want to be the best candidate I can be and for that reason, I desire to obtain as much research experience as I can as an undergrad. I want to further develop a research/problem solving mentality and work on my shortfalls.  Even though I have some experience, I still feel like a novice when it comes to doing research. I really want to become versed in common analysis methods, lab procedures, and methodology development.  I feel my other shortfall is detail searching.  When I do research I spend a lot of time trying to understand every detail and aspect of it. This is useful in fully understanding applications and mechanics, but sometimes it hinders research progress and is time costly.  I would like to find the appropriate balance of research progress and detail searching. I am trying to obtain as much research as I can so that I may have many skills and tools for when I apply for graduate school. This program will give me the opportunity to learn the necessary skills to work efficiency and productively in my career.  Furthermore, I know the program with provide me with a stimulating and challenging atmosphere that will push me to develop into a better researcher.",
  :learn => "NSF REU Website")

# create recommender
s.recommender = Recommender.new(:name => "Martin Van Buren", :title => "Professor", :department => "Intergrative Biology", :college => "University of California, Berkeley", :phone => "510-448-8404", :email => "mvburen@be.ucsd.edu", :waive_rights => true)
s.save

# create recommendation
s.recommendation = Recommendation.new( :known_student => "<1 year", :know_capacity => "Undergrad in one course", :rating => "Top 10%", :undergrad_inst => "No",
  :faculty_comment => "To whom it may concern:\r\n\r\n\tI write to recommend Peter Chen for a summer research internship.  I have known Peter since fall semester, 2010, as a student in my biomedical engineering physiology course, in which he earned a grade of A- and ranked at about the middle among the 132 students.  This course was taught using Koeppen and Stanton’s new sixth edition of Berne and Levy’s Physiology text with full coverage in two semesters.  Students write three critiques of published papers, four exams and quantitative homework problems.  It is the only physiology course outside the medical school curriculum.\r\n\tPeter’s overall performance in all of his classes would rank him among the top 15% of students in engineering at UVA.  He is earning a major in biomedical engineering and doing very well.  He is an engaging student, disciplined and intelligent.  He works hard, is organized, honest and imaginative.  Peter asks thoughtful questions about both his classroom work and his plans for the future.  \r\n\tI believe you will find that Peter will make significant contributions to your program and I recommend him most enthusiastically.  He has demonstrated the highest intellectual rigor and a consistent motivation for excellence in his course work.  I would be happy to respond to questions.\r\n\r\nSincerely,\r\n\r\nJ. Milton Adams Ph.D.\r\nProfessor, Biomedical Engineering\r\nVice Provost for Academic Programs\r\n")
s.save

#
# WITHDRAWN STUDENT
#
# create sample students
s = User.new( :firstname => "Theodore", :middlename => "", :lastname => "Roosevelt", :email => "troosevelt@be.ucsd.edu", :dob => "1991-07-12 07:00:00", :street => "PO#50442    9450 Gilman Dr", :city => "La Jolla", :state => "CA", :zip => "92092", 
  :phone => "805-663-4445", :pstreet => "252 Plum Ave", :pcity => "Ventura", :pstate => "CA", :pzip => "93004", :pphone => nil, :citizenship => "United States", :cresidence => "", 
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
  :transcript_file_name => "UCSDTranscript.pdf")
s.save