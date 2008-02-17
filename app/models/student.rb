require 'digest/sha1'
class Student < ActiveRecord::Base
  belongs_to                :recommender
  validates_presence_of     :firstname, :lastname, :street, :city, :state, :zip, :phone, :email, :citizenship, :college, :college_start, :college_end, :college_level, :major, :gpa, :gpa_range, :personal_statement
  validates_format_of       :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
  before_create :make_token
  after_create :make_pdf, :email_recommender
  
  def make_pdf
    pdf = PDF::Writer.new
    pdf.text "Application for #{self.firstname} #{self.lastname}\n\n", :font_size => 22, :justification => :center
    y0 = pdf.y + 18
    pdf.move_pointer(24)
    @methods = %w{awards research_experience gpa_comments personal_statement}
    @methods.each do |m|  
      pdf.text "#{m.gsub("_"," ").capitalize }\n", 
        :font_size => 13, 
        :justification => :left, 
        :left => 50, 
        :right => 50
      pdf.text "#{send(m)}\n\n", 
        :font_size => 11, 
        :justification => :left, 
        :left => 50, 
        :right => 50
    end
      pdf.rounded_rectangle(pdf.left_margin + 25, y0, pdf.margin_width - 50, y0 - pdf.y + 18, 10).stroke
      pdf.save_as("#{RAILS_ROOT}/public/pdf/#{self.id.to_s}_#{self.lastname}.pdf")
  end
  
  def email_recommender
    email = RecommendationMailer.create_rec_request(
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
      self.awards.gsub("\n", "<br/>").insert(0, "<br/>"), 
      self.research_experience.gsub("\n", "<br/>").insert(0, "<br/>"), 
      self.gpa_comments.gsub("\n", "<br/>").insert(0, "<br/>"), 
      self.personal_statement.gsub("\n", "<br/>").insert(0, "<br/>"))      
    email.set_content_type('multipart', 'mixed')
    RecommendationMailer.deliver(email)
  end
  
 protected 
  def make_token 
    self.token = Digest::SHA1.hexdigest(Time.now.to_s.split(//).sort_by{rand}.join) 
  end
  
end