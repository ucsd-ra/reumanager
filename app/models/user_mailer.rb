class UserMailer < ActionMailer::Base

  def reg_confirmation( firstname, lastname, email)
    @subject    = "UCSD Bioengineering - NSF REU Registration Confirmation for #{firstname} #{lastname}"
    @recipients = email
    @from       = 'UCSD Bioengineering - NSFREU <nsfreu@bioeng.ucsd.edu>'
    @sent_on    = Time.now
    @headers    = {}

    part(
      :content_type => "text/html", 
      :body => render_message("reg_confirmation",
                              :firstname => firstname,
                              :lastname => lastname,
                              :email => email)
      )
  end

  def app_confirmation( id, token, firstname, lastname, email)
    @subject    = "UCSD Bioengineering - NSF REU Application Confirmation for #{firstname} #{lastname}"
    @recipients = email
    @from       = 'UCSD Bioengineering - NSFREU <nsfreu@bioeng.ucsd.edu>'
    @sent_on    = Time.now
    @headers    = {}

    part(
      :content_type => "text/html", 
      :body => render_message("app_confirmation",
                              :firstname => firstname,
                              :lastname => lastname,
                              :email => email,
                              :token => token)
      )
  end

  def rec_request(remail, id, token, firstname, lastname, email)
    @subject    = "UCSD Bioengineering - NSF REU Recommendation Request from #{firstname} #{lastname}"
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
                              :lastname => lastname, 
                              :email => email )
      )
  end
    
  def complete_app(id, firstname, lastname, email)
      @subject    = "UCSD Bioengineering - NSF REU Complete Application for #{firstname} #{lastname}"
      @recipients = ['UCSD Bioengineering - NSF REU <nsfreu@bioeng.ucsd.edu>']
      @from       = 'UCSD Bioengineering - NSFREU <nsfreu@bioeng.ucsd.edu>'
      @sent_on    = Time.now
      @headers    = {}

      part(
        :content_type => "text/html", 
        :body => render_message("complete_app",
                                :id => id,
                                :firstname => firstname,
                                :lastname => lastname, 
                                :email => email)
        )
      attachment :content_type => "application/pdf", :filename => "#{id.to_s}_#{lastname}.pdf", :body => File.read("#{RAILS_ROOT}/public/pdf/#{id.to_s}_#{lastname}.pdf")
    end
    
    def complete_app_student(firstname, lastname, email)
        @subject    = "UCSD Bioengineering - NSF REU Complete Application for #{firstname} #{lastname}"
        @recipients = email
        @from       = 'UCSD Bioengineering - NSFREU <nsfreu@bioeng.ucsd.edu>'
        @sent_on    = Time.now
        @headers    = {}

        part(
          :content_type => "text/html", 
          :body => render_message("complete_app_student",
                                  :firstname => firstname,
                                  :lastname => lastname, 
                                  :email => email)
          )
      end
    

end