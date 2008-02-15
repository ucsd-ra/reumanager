class RecommendationMailer < ActionMailer::Base

  def rec_request(firstname, middlename, lastname, phone, email, citizenship, college, college_start, college_end, college_level, major, gpa, gpa_range, awards, research_experience, gpa_comments, personal_statement)
    @subject    = 'NSF REU Request'
    @body       = { 
      :firstname => firstname, 
      :middlename => middlename, 
      :lastname => lastname, 
      :phone  => phone, 
      :email => email,
      :citizenship => citizenship, 
      :college => college, 
      :college_start => college_start, 
      :college_end => college_end, 
      :college_level => college_level, 
      :major => major, 
      :gpa => gpa, 
      :gpa_range => gpa_range, 
      :awards => awards,
      :research_experience => research_experience,
      :gpa_comments => gpa_comments,
      :personal_statement =>personal_statement  
      }
    @recipients = 'jgrevich@gmail.com'
    @from       = 'jgrevich@ucsd.edu'
    @sent_on    = Time.now
    @headers    = {}
  end


end
