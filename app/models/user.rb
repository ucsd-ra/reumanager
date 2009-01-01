require 'digest/sha1'
require 'pdf/writer'
class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  
  has_one                   :academic_record
  has_one                   :recommendation
  has_one                   :recommender
  has_one                   :extra
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
  after_create  :send_confirmation
  
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
     pdf.text "#{self.college_level.capitalize} majoring in #{self.major} at #{self.college}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
     pdf.text "Attended from: #{self.college_start} to #{self.college_end}, GPA: #{self.gpa} out of #{self.gpa_range}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
     if self.p_college != ""
       pdf.text "Previous college: #{p_college}, Attended from: #{self.pcollege_start} to #{self.pcollege_end}\n\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
     else
       pdf.text "\n"
     end

     @methods = %w{awards lab_skills comp_skills gpa_comments personal_statement}
     @methods.each do |m|  
       pdf.text "#{m.gsub("_"," ").capitalize }\n", :font_size => 13, :justification => :left, :left => 33, :right => 33
       pdf.text "#{send(m)}\n\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
     end
       pdf.save_as("#{RAILS_ROOT}/public/pdf/#{self.id.to_s}_#{self.lastname}.pdf")
   end

   def email_recommender
     email = UserMailer.create_rec_request(
       self.recommender.email, 
       self.id, 
       self.token, 
       self.firstname, 
       self.middlename, 
       self.lastname, 
       self.phone, 
       self.email, 
       self.citizenship, 
       self.college, 
       self.college_start, 
       self.college_end, 
       self.college_level, 
       self.major, 
       self.gpa, 
       self.gpa_range, 
       self.awards.gsub("\n", "<br />").insert(0, "<br />"), 
       self.lab_skills.gsub("\n", "<br />").insert(0, "<br />"), 
       self.comp_skills.gsub("\n", "<br />").insert(0, "<br />"), 
       self.gpa_comments.gsub("\n", "<br />").insert(0, "<br />"), 
       self.personal_statement.gsub("\n", "<br />").insert(0, "<br />"))      
     email.set_content_type('multipart', 'mixed')
     UserMailer.deliver(email)
   end

   def send_confirmation
     email = UserMailer.create_confirmation(
       self.id, 
       self.token, 
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
