require 'digest/sha1'
class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  
  has_one                   :academic_record, :dependent => :destroy
  has_one                   :recommendation, :dependent => :destroy
  has_one                   :recommender, :dependent => :destroy
  has_one                   :extra, :dependent => :destroy
  has_one                   :transcript, :dependent => :destroy


  validates_format_of       :firstname,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :firstname,     :maximum => 100
  validates_format_of       :lastname,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :lastname,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
  validates_presence_of     :dob, :street, :city, :state, :zip, :phone, :email, :citizenship
  

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :firstname, :middlename, :lastname, :dob, :street, :city, :state, :zip, :phone, :pstreet, :pcity, :pstate, :pzip, :pphone, :citizenship, :gender, :ethnicity, :race, :disability, :password, :password_confirmation

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  
  
  before_create :make_token
  after_create  :send_reg_confirmation
  
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login) # need to get the salt
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

     pdf.text "Academic Info\n", :font_size => 13, :justification => :left, :left => 33, :right => 33
     pdf.text "#{self.academic_record.college_level.capitalize} majoring in #{self.academic_record.major} at #{self.academic_record.college}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
     pdf.text "Attended from: #{self.academic_record.college_start} to #{self.academic_record.college_end}, GPA: #{self.academic_record.gpa} out of #{self.academic_record.gpa_range}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
     if self.academic_record.p_college != ""
       pdf.text "Previous college: #{self.academic_record.p_college}, Attended from: #{self.academic_record.pcollege_start} to #{self.academic_record.pcollege_end}\n\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
     else
       pdf.text "\n"
     end

     @methods = %w{awards lab_skills comp_skills gpa_comments personal_statement}
     @methods.each do |m|  
       pdf.text "#{m.gsub("_"," ").capitalize }\n", :font_size => 13, :justification => :left, :left => 33, :right => 33
       pdf.text "#{self.extra.send(m)}\n\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
     end
       pdf.save_as("#{RAILS_ROOT}/public/pdf/#{self.id.to_s}_#{self.lastname}.pdf")
   end

   def send_reg_confirmation
     email = UserMailer.create_reg_confirmation(
       self.firstname, 
       self.lastname, 
       self.email
     )      
     email.set_content_type('multipart', 'mixed')
     UserMailer.deliver(email)
   end

   def send_app_confirmation
     self.update_attribute("submit_date", Time.now)     
     email = UserMailer.create_app_confirmation(
       self.id, 
       self.token, 
       self.firstname, 
       self.lastname, 
       self.email
     )      
     email.set_content_type('multipart', 'mixed')
     UserMailer.deliver(email)
   end

   def send_rec_request
     self.update_attribute("rec_request", Time.now)
     email = UserMailer.create_rec_request(
      self.recommender.email, 
      self.id, 
      self.token, 
      self.firstname, 
      self.lastname, 
      self.email
      )
     email.set_content_type('multipart', 'mixed')
     UserMailer.deliver(email)
   end

   def send_complete_app
     self.update_attribute("completed", Time.now)     
     email = UserMailer.create_complete_app(
       self.id,
       self.firstname, 
       self.lastname, 
       self.email
     )      
     email.set_content_type('multipart', 'mixed')
     UserMailer.deliver(email)
   end
   
   def send_complete_app_student
     email = UserMailer.create_complete_app_student(
       self.firstname, 
       self.lastname, 
       self.email
     )      
     email.set_content_type('multipart', 'mixed')
     UserMailer.deliver(email)
   end
   
  protected
    def make_token 
      self.token = Digest::SHA1.hexdigest(Time.now.to_s.split(//).sort_by{rand}.join) 
    end
end
