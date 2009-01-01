class UserMailer < ActionMailer::Base

  def confirmation( id, token, firstname, lastname, email)
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
                              :token => token)
      )
  end

end
