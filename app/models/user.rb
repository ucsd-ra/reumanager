require 'digest/sha1'
class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  
  belongs_to                :role
  has_one                   :academic_record, :dependent => :destroy
  has_one                   :recommendation, :dependent => :destroy
  has_one                   :recommender, :dependent => :destroy
  has_one                   :second_recommendation, :dependent => :destroy
  has_one                   :second_recommender, :dependent => :destroy
  has_one                   :extra, :dependent => :destroy
  
  validates_format_of       :firstname,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :firstname,     :maximum => 100
  validates_format_of       :lastname,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :lastname,     :maximum => 100
  validates_length_of       :password, :within => 8..40, :if => :password_required?
  
  validates_presence_of     :email, :firstname, :lastname, :father_edu, :mother_edu
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
  validates_presence_of     :dob, :street, :city, :state, :zip, :phone, :email, :citizenship
  
  validates_inclusion_of    :citizenship, :in => ['United States', 'U.S. Permanent Resident'], :message => "must be in the United States or as US Permanent Resident status in order to continue with the application."

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :firstname, :middlename, :lastname, :dob, :street, :city, :state, :zip, :phone, :pstreet, :pcity, :pstate, :pzip, :pphone, :citizenship, :cresidence, :gender, :ethnicity, :race, :disability, :password, :password_confirmation, :emailed_rejection_letter_at, :emailed_waitlist_letter_at, :birth_place, :father_edu, :mother_edu

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  cattr_reader :per_page
  @@per_page = 20
  
  before_create :make_token
    
  def name
    @name = ""
    @name << (self.firstname + " ") if self.firstname
    @name << (self.middlename + " ") if self.middlename && self.middlename != ''
    @name << (self.lastname) if self.lastname
  end
  
  # Activates the user in the database.
  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.make_token
    save(false)
  end
  
  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def active?
    # the lack of an activation code means they have not activated yet
    !self.activated_at.nil?
  end
  
  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find :first, :conditions => ['login = ? and activated_at IS NOT NULL', login] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

	def make_pdf
		pdf = PDF::Writer.new
		pdf.text "NSF REU Application for #{self.firstname} #{self.lastname}\n\n", :font_size => 22, :justification => :center
		pdf.move_pointer(24)

		pdf.text "Personal Data\n", :font_size => 13, :justification => :left, :left => 33, :right => 33
		pdf.text "#{self.street}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
		pdf.text "#{self.city}, #{self.state} #{self.zip}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33

		if self.citizenship == "United States"
			pdf.text "Citizenship: #{self.citizenship}\n\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
		else
			pdf.text "Citizenship: #{self.citizenship}, Country of Residence: #{self.cresidence}\n\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
		end

		if self.academic_record
			pdf.text "Academic Info\n", :font_size => 13, :justification => :left, :left => 33, :right => 33

			pdf.text "#{self.academic_record.college_level.capitalize} majoring in #{self.academic_record.major} at #{self.academic_record.college}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
			pdf.text "Attended from: #{self.academic_record.college_start} to #{self.academic_record.college_end}, GPA: #{self.academic_record.gpa} out of #{self.academic_record.gpa_range}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33

			if self.academic_record.p_college != ""
				pdf.text "Previous college: #{self.academic_record.p_college}, Attended from: #{self.academic_record.p_college_start} to #{self.academic_record.p_college_end}\n\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
			else
				pdf.text "\n"
			end

			@methods = %w{awards lab_skills comp_skills gpa_comments personal_statement mentor1 mentor2 mentor3}
			@methods.each do |m|
				if self.extra
					pdf.text "#{m.gsub("_"," ").capitalize }\n", :font_size => 13, :justification => :left, :left => 33, :right => 33
					pdf.text "#{self.extra.send(m)}\n\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
				end
			end
		else
			pdf.text "No academic record yet.."
		end

		if self.recommender && @recommender = Recommender.find_by_id(self.recommender)
			pdf.text "Recommendation for #{self.firstname} #{self.lastname}\n\n", :font_size => 20, :justification => :left
			pdf.move_pointer(24)

			pdf.text "Recommender Personal Data\n", :font_size => 13, :justification => :left, :left => 33, :right => 33
			pdf.text "#{@recommender.name}, #{@recommender.title}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
			pdf.text "#{@recommender.college}, #{@recommender.department}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
			pdf.text "#{@recommender.email}, #{@recommender.phone}\n\n", :font_size => 11, :justification => :left, :left => 33, :right => 33

			if self.recommendation
				pdf.text "Student Information\n", :font_size => 13, :justification => :left, :left => 33, :right => 33
				pdf.text "How long have you known the applicant: #{self.recommendation.known_student}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
				pdf.text "In what capacity have you known the applicant: #{self.recommendation.know_capacity}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
				pdf.text "Please rate the applicant's overall promise in comparison with other individuals whom you have known at similar stages in their careers: #{self.recommendation.rating}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
				pdf.text "What is the applicant's GPA: #{self.recommendation.gpa} out of #{self.recommendation.gpa_range}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
				pdf.text "Is your institution primarily an undergraduate institution: #{self.recommendation.undergrad_inst}\n\n", :font_size => 11, :justification => :left, :left => 33, :right => 33 

				pdf.text "Faculty Recommendation\n", :font_size => 13, :justification => :left, :left => 33, :right => 33
				pdf.text "#{self.recommendation.faculty_comment}", :font_size => 11, :justification => :left, :left => 33, :right => 33
			else
				pdf.text "No recommendation yet..."
			end
		else
				pdf.text "No recommender yet..."
		end
		
		pdf.save_as("#{RAILS_ROOT}/public/pdf/#{self.id.to_s}_#{self.lastname}.pdf")
	end

   def send_reg_confirmation
     email = UserMailer.create_reg_confirmation(self.firstname, self.lastname, self.email, self.token)
     email.set_content_type('multipart', 'mixed')
     UserMailer.deliver(email)
   end

   def send_app_confirmation
     self.update_attribute("submitted_at", Time.now)     
     email = UserMailer.create_app_confirmation(self.id, self.token, self.firstname, self.lastname, self.email)
     email.set_content_type('multipart', 'mixed')
     UserMailer.deliver(email)
   end

   def send_rec_request
     self.update_attribute("rec_request_at", Time.now)
     email = UserMailer.create_rec_request(self.recommender.email, self.id, self.token, self.firstname, self.lastname, self.email)
     email.set_content_type('multipart', 'mixed')
     UserMailer.deliver(email)
   end

   def send_rec_reminder
     self.update_attribute("rec_request_at", Time.now)
     email = UserMailer.create_rec_reminder(self.recommender.email, self.id, self.token, self.firstname, self.lastname, self.email)
     email.set_content_type('multipart', 'mixed')
     UserMailer.deliver(email)
   end
   
   def send_second_rec_request
     self.update_attribute("second_rec_request_at", Time.now)
     email = UserMailer.create_rec_request(self.second_recommender.email, self.id, self.token, self.firstname, self.lastname, self.email)
     email.set_content_type('multipart', 'mixed')
     UserMailer.deliver(email)
   end

   def send_second_rec_reminder
     self.update_attribute("second_rec_request_at", Time.now)
     email = UserMailer.create_rec_reminder(self.second_recommender.email, self.id, self.token, self.firstname, self.lastname, self.email)
     email.set_content_type('multipart', 'mixed')
     UserMailer.deliver(email)
   end

   def send_complete_app
     email = UserMailer.create_complete_app(self.id, self.firstname, self.lastname, self.email)
     email.set_content_type('multipart', 'mixed')
     UserMailer.deliver(email)
   end
   
   def send_complete_app_student
     self.update_attribute("completed_at", Time.now)
     email = UserMailer.create_complete_app_student(self.firstname, self.lastname, self.email)
     email.set_content_type('multipart', 'mixed')
     UserMailer.deliver(email)
   end
   
   def send_application_reminder
     email = UserMailer.create_application_reminder(self.firstname, self.lastname, self.email)
     email.set_content_type('multipart', 'mixed')
     UserMailer.deliver(email)
   end
   
   def set_to_admin!
     self.activate!
     self.role = Role.find 1
     self.save_with_validation(false)
   end
   
   def make_token
     self.token = Digest::SHA1.hexdigest(Time.now.to_s.split(//).sort_by{rand}.join)
     self.token_created_at = Time.now
   end

   def make_pw_token
     self.pw_token = Digest::SHA1.hexdigest(Time.now.to_s.split(//).sort_by{rand}.join)
     self.pw_token_created_at = Time.now
   end

		def self.send_reminders
			@users = User.all :conditions => ["role_id = ?", 1]
			@users.each do |u|
				u.send_reg_confirmation
			end
	  end
	  
	  def send_rejection_letter
      if self.emailed_rejection_letter_at == nil
        email = UserMailer.create_rejection_letter(self)
        email.set_content_type('multipart', 'mixed')
        if sleep(0.5) && UserMailer.deliver(email)
          self.update_attribute(:emailed_rejection_letter_at, Time.now)
          puts "--> delivered rejection letter for #{self.name} (#{self.email})"
        else
          puts "*** Error sending rejection letter"
        end
      else
        self.emailed_rejection_letter_at == nil ? puts("*** Already sent waitlist letter to #{self.name} (#{self.email})") : puts("*** Already sent rejection letter to #{self.name} (#{self.email})")
      end
    end

    def send_waitlist_letter
      if self.emailed_waitlist_letter_at == nil && self.emailed_rejection_letter_at == nil
        email = UserMailer.create_waitlist_letter(self)
        email.set_content_type('multipart', 'mixed')
        if sleep(0.5) && UserMailer.deliver(email)
          self.update_attribute(:emailed_waitlist_letter_at, Time.now)
          puts "---> delivered waitlist letter for #{self.name} (#{self.email})"
        else
          puts "*** Error sending waitlist letter"
        end
      else
        self.emailed_rejection_letter_at == nil ? puts("*** Already sent waitlist letter to #{self.name} (#{self.email})") : puts("*** Already sent rejection letter to #{self.name} (#{self.email})")
      end
    end

end