class UserMailer < ActionMailer::Base

  def reg_confirmation( firstname, lastname, email, token)
    @subject    = "#{Setting.app_title} Confirmation for #{firstname} #{lastname}"
    @recipients = email
    @from       = "#{Setting.university} #{Setting.department} <#{Setting.mail_from}>"
    @sent_on    = Time.now
    @headers    = {}

    part(
      :content_type => "text/html", 
      :body => render_message("reg_confirmation",
                              :firstname => firstname,
                              :lastname => lastname,
                              :email => email,
                              :token => token)
    )
  end

  def app_confirmation( id, token, firstname, lastname, email)
    @subject    = "#{Setting.app_title} Confirmation for #{firstname} #{lastname}"
    @recipients = email
    @from       = "#{Setting.university} #{Setting.department} <#{Setting.mail_from}>"
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

    
  def complete_app(id, firstname, lastname, email)
    @subject    = "#{Setting.app_title} Completed Application for #{firstname} #{lastname}"
    @recipients = # 'UCSD Bioengineering - NSF REU <nsfreu@be.ucsd.edu>', 
    @from       = "#{Setting.university} #{Setting.department} <#{Setting.mail_from}>"
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
    attachment :content_type => "application/pdf", :filename => "#{id.to_s}_#{lastname}.pdf", :body => File.read("#{RAILS_ROOT}/public/pdf/#{self.firstname}-#{self.lastname}-#{self.token}.pdf")
  end
  
  def complete_app_student(firstname, lastname, email)
    @subject    = "#{Setting.app_title} Completed Application for #{firstname} #{lastname}"
    @recipients = email
    @from       = "#{Setting.university} #{Setting.department} <#{Setting.mail_from}>"
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
  
  def application_reminder(firstname, lastname, email)
    @subject    = "#{Setting.app_title} Application Reminder for #{firstname} #{lastname}"
    @recipients = email
    @from       = "#{Setting.university} #{Setting.department} <#{Setting.mail_from}>"
    @sent_on    = Time.now
    @headers    = {}

    part(
      :content_type => "text/html", 
      :body => render_message("application_reminder",
                              :firstname => firstname,
                              :lastname => lastname, 
                              :email => email)
      )
  end

  def rec_request(remail, id, token, firstname, lastname, email)
    @subject    = "#{Setting.app_title} Recommendation Request for #{firstname} #{lastname}"
    @recipients = remail
    @from       = "#{Setting.university} #{Setting.department} <#{Setting.mail_from}>"
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
  
  def rec_reminder(remail, id, token, firstname, lastname, email)
    @subject    = "#{Setting.app_title} Recommendation Request for #{firstname} #{lastname}"
    @recipients = remail
    @from       = "#{Setting.university} #{Setting.department} <#{Setting.mail_from}>"
    @sent_on    = Time.now
    @headers    = {}

    part(
      :content_type => "text/html", 
      :body => render_message("rec_reminder",
                              :id => id,
                              :token => token,
                              :firstname => firstname,
                              :lastname => lastname, 
                              :email => email )
    )
  end

  def rec_confirmation(remail, firstname, lastname, email)
    @subject    = "#{Setting.app_title} Recommendation Confirmation for #{firstname} #{lastname}"
    @recipients = remail
    @from       = "#{Setting.university} #{Setting.department} <#{Setting.mail_from}>"
    @sent_on    = Time.now
    @headers    = {}

    part(
      :content_type => "text/html", 
      :body => render_message("rec_confirmation",
                              :firstname => firstname,
                              :lastname => lastname, 
                              :email => email )
    )
  end

  def reset_password(user)
    @subject    = "#{Setting.app_title} Password reset link for #{user.firstname} #{user.lastname}"
    @recipients = user.email
    @from       = "#{Setting.university} #{Setting.department} <#{Setting.mail_from}>"
    @sent_on    = Time.now
    @headers    = {}

    part( :content_type => "text/html", :body => render_message("reset_password", :user => user ))
  end

  def rejection_letter(user)
    sleep(4.5)
    @subject    = "#{Setting.app_title} Application Status for #{user.firstname} #{user.lastname}"
    @recipients = user.email
    @from       = "#{Setting.university} #{Setting.department} <#{Setting.mail_from}>"
    @sent_on    = Time.now
    @headers    = {}

    part( :content_type => "text/html", :body => render_message("rejection_letter", :user => user ))
  end

  def waitlist_letter(user)
    @subject    = "UCSD REU Application Status for #{user.firstname} #{user.lastname}"
    @recipients = user.email
    @from       = "#{Setting.university} #{Setting.department} <#{Setting.mail_from}>"
    @sent_on    = Time.now
    @headers    = {}

    part( :content_type => "text/html", :body => render_message("waitlist_letter", :user => user ))
  end

end