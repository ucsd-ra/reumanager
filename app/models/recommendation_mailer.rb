class RecommendationMailer < ActionMailer::Base

  def rec_request(remail, id, token, firstname, middlename, lastname, phone, email, citizenship, college, college_start, college_end, college_level, major, gpa, gpa_range, awards, lab_skills, comp_skills, gpa_comments, personal_statement)
    @subject    = 'UCSD Bioengineering - NSF REU Recommendation Request'
    @recipients = remail
    @from       = 'UCSD Bioengineering - NSFREU <nsfreu@bioeng.ucsd.edu>'
    @sent_on    = Time.now
    @headers    = {}

    part(
      :content_type => "text/html", 
      :body => render_message("rec_request", 
                              :id => id,
                              :token => token,
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
                              :lab_skills => lab_skills,
                              :comp_skills => comp_skills,
                              :gpa_comments => gpa_comments,
                              :personal_statement =>personal_statement )
      )
    attachment :content_type => "application/pdf", :filename => "#{id.to_s}_#{lastname}.pdf", :body => File.read("#{RAILS_ROOT}/public/pdf/#{id.to_s}_#{lastname}.pdf")
  end
  
  def confirmation(rname, rtitle, rdept, rcollege, rphone, remail, id, token, firstname, lastname, email)
    @subject    = "UCSD Bioengineering - NSF REU Confirmation for #{firstname} #{lastname}"
    @recipients = email
    @from       = 'UCSD Bioengineering - NSFREU <nsfreu@bioeng.ucsd.edu>'
    @sent_on    = Time.now
    @headers    = {}

    part(
      :content_type => "text/html", 
      :body => render_message("confirmation",
                              :firstname => firstname,
                              :lastname => lastname,
                              :email => email,
                              :rname => rname,
                              :rtitle => rtitle,
                              :rdept => rdept,
                              :rcollege => rcollege,
                              :rphone => rphone,
                              :remail => remail )
      )
    attachment :content_type => "application/pdf", :filename => "#{id.to_s}_#{lastname}.pdf", :body => File.read("#{RAILS_ROOT}/public/pdf/#{id.to_s}_#{lastname}.pdf")
  end
  
  def recommendation_email(id, firstname, middlename, lastname, email)
      @subject    = 'UCSD Bioengineering - NSF REU Recommendation'
      @recipients = ['UCSD Bioengineering - NSF REU <nsfreu@bioeng.ucsd.edu>']
      @from       = 'UCSD Bioengineering - NSFREU <nsfreu@bioeng.ucsd.edu>'
      @sent_on    = Time.now
      @headers    = {}

      part(
        :content_type => "text/html", 
        :body => render_message("recommendation_email",
                                :id => id,
                                :firstname => firstname, 
                                :middlename => middlename, 
                                :lastname => lastname, 
                                :email => email)
        )
      attachment :content_type => "application/pdf", :filename => "#{id.to_s}_#{lastname}_rec.pdf", :body => File.read("#{RAILS_ROOT}/public/pdf/#{id.to_s}_#{lastname}_rec.pdf")
    end
    
end
