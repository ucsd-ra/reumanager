class Recommendation < ActiveRecord::Base
  belongs_to                :student
  belongs_to                :recommender
  validates_presence_of     :known_student, :know_capacity, :rating, :gpa, :gpa_range, :undergrad_inst, :faculty_comment
  
  after_create :make_pdf, :send_recommendation
  
  def make_pdf
    @student = Student.find_by_id(self.student_id)
    @recommender = Recommender.find_by_id(self.recommender_id)
    pdf = PDF::Writer.new
    pdf.text "NSF REU Recommendation for #{@student.firstname} #{@student.lastname}\n\n", :font_size => 22, :justification => :center
    pdf.move_pointer(24)

    pdf.text "Recommender Personal Data\n", :font_size => 13, :justification => :left, :left => 33, :right => 33
    pdf.text "#{@recommender.name}, #{@recommender.title}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    pdf.text "#{@recommender.college}, #{@recommender.department}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    pdf.text "#{@recommender.email}, #{@recommender.phone}\n\n", :font_size => 11, :justification => :left, :left => 33, :right => 33

    pdf.text "Student Information\n", :font_size => 13, :justification => :left, :left => 33, :right => 33
    pdf.text "How long have you known the applicant: #{self.known_student}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    pdf.text "In what capacity have you known the applicant: #{self.know_capacity}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    pdf.text "Please rate the applicant's overall promise in comparison with other individuals whom you have known at similar stages in their careers: #{self.rating}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    pdf.text "What is the applicant's GPA: #{self.gpa} out of #{self.gpa_range}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    pdf.text "Is your institution primarily an undergraduate institution: #{self.undergrad_inst}\n\n", :font_size => 11, :justification => :left, :left => 33, :right => 33 
    
    pdf.text "Faculty Recommendation\n", :font_size => 13, :justification => :left, :left => 33, :right => 33
    pdf.text "#{self.faculty_comment}", :font_size => 11, :justification => :left, :left => 33, :right => 33
    
    pdf.save_as("#{RAILS_ROOT}/public/pdf/#{@student.id.to_s}_#{@student.lastname}_rec.pdf")
  end
  
  def send_recommendation    
    @student = Student.find_by_id(self.student_id)
    email = RecommendationMailer.create_recommendation_email(@student.id, @student.firstname, @student.middlename, @student.lastname, @student.email)
    email.set_content_type('multipart', 'mixed')
    RecommendationMailer.deliver(email)
  end
end
