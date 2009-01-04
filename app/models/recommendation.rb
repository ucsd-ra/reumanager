class Recommendation < ActiveRecord::Base
  belongs_to                :user
  belongs_to                :recommender
  validates_presence_of     :known_student, :know_capacity, :rating, :gpa, :gpa_range, :undergrad_inst, :faculty_comment
  
  after_create :make_pdf_and_send_app
  
  def make_pdf_and_send_app
    @user = User.find_by_id(self.user_id)
    @recommender = Recommender.find_by_id(self.recommender_id)
    pdf = PDF::Writer.new
    pdf.text "Recommendation for #{@user.firstname} #{@user.lastname}\n\n", :font_size => 20, :justification => :left
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

    pdf.move_pointer(24)    
    pdf.text "Application for #{@user.firstname} #{@user.lastname}\n\n", :font_size => 20, :justification => :left
    pdf.move_pointer(24)

    pdf.text "Personal Data\n", :font_size => 13, :justification => :left, :left => 33, :right => 33
    pdf.text "#{@user.street}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    pdf.text "#{@user.city}, #{@user.state} #{@user.zip}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    if @user.citizenship == "United States"
      pdf.text "Citizenship: #{@user.citizenship}\n\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    else
      pdf.text "Citizenship: #{@user.citizenship}, Country of Residence: #{@user.cresidence}\n\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    end

    pdf.text "Academic Info\n", :font_size => 13, :justification => :left, :left => 33, :right => 33
    pdf.text "#{@user.academic_record.college_level.capitalize} majoring in #{@user.academic_record.major} at #{@user.academic_record.college}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    pdf.text "Attended from: #{@user.academic_record.college_start} to #{@user.academic_record.college_end}, GPA: #{@user.academic_record.gpa} out of #{@user.academic_record.gpa_range}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    if @user.academic_record.p_college != ""
      pdf.text "Previous college: #{@user.academic_record.p_college}, Attended from: #{@user.academic_record.pcollege_start} to #{@user.academic_record.pcollege_end}\n\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    else
      pdf.text "\n"
    end

    @extras = %w{awards lab_skills comp_skills gpa_comments personal_statement}
    @extras.each do |e|  
      pdf.text "#{e.gsub("_"," ").capitalize }\n", :font_size => 13, :justification => :left, :left => 33, :right => 33
      pdf.text "#{@user.extra.send(e)}\n\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    end    
    pdf.save_as("#{RAILS_ROOT}/public/pdf/#{@user.id.to_s}_#{@user.lastname}.pdf")
    @user.send_complete_app
    @user.send_complete_app_student
    @user.completed = Time.now
  end
  
  def make_pdf
    @user = User.find_by_id(self.user_id)
    @recommender = Recommender.find_by_id(self.recommender_id)
    pdf.text "Recommendation for #{@user.firstname} #{@user.lastname}\n\n", :font_size => 20, :justification => :left
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

    pdf.move_pointer(24)    
    pdf.text "Application for #{@user.firstname} #{@user.lastname}\n\n", :font_size => 20, :justification => :left
    pdf.move_pointer(24)

    pdf.text "Personal Data\n", :font_size => 13, :justification => :left, :left => 33, :right => 33
    pdf.text "#{@user.street}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    pdf.text "#{@user.city}, #{@user.state} #{@user.zip}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    if @user.citizenship == "United States"
      pdf.text "Citizenship: #{@user.citizenship}\n\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    else
      pdf.text "Citizenship: #{@user.citizenship}, Country of Residence: #{@user.cresidence}\n\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    end

    pdf.text "Academic Info\n", :font_size => 13, :justification => :left, :left => 33, :right => 33
    pdf.text "#{@user.academic_record.college_level.capitalize} majoring in #{@user.academic_record.major} at #{@user.academic_record.college}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    pdf.text "Attended from: #{@user.academic_record.college_start} to #{@user.academic_record.college_end}, GPA: #{@user.academic_record.gpa} out of #{@user.academic_record.gpa_range}\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    if @user.academic_record.p_college != ""
      pdf.text "Previous college: #{@user.academic_record.p_college}, Attended from: #{@user.academic_record.pcollege_start} to #{@user.academic_record.pcollege_end}\n\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    else
      pdf.text "\n"
    end

    @extras = %w{awards lab_skills comp_skills gpa_comments personal_statement}
    @extras.each do |e|  
      pdf.text "#{e.gsub("_"," ").capitalize }\n", :font_size => 13, :justification => :left, :left => 33, :right => 33
      pdf.text "#{@user.extra.send(e)}\n\n", :font_size => 11, :justification => :left, :left => 33, :right => 33
    end    
    pdf.move_pointer(48)
  end
    
end