module ApplicationHelper
  
  def errors_for(object, message=nil)
    html = ""
    unless object.errors.blank?
      html << "<div id='error_explanation' onclick='$(this).slideUp();'>\n"
      if message.blank?
        if object.new_record?
          html << "\t\t<h2>There was a problem creating the #{object.class.name.humanize.downcase}</h2>\n"
        else
          html << "\t\t<h2>There was a problem updating the #{object.class.name.humanize.downcase}</h2>\n"
        end    
      else
        html << "<h2>#{message}</h2>"
      end  
      html << "\t\t<ul>\n"
      object.errors.full_messages.each do |error|
        html << "\t\t\t<li>#{error}</li>\n"
      end
      html << "\t\t</ul>\n"
      html << "\t</div>\n"
    end
    raw html
  end  
  
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields btn btn-mini btn-success", data: {id: id, fields: fields.gsub("\n", "")})
  end
  
  def microsloth_sucks
    html = '<script src="https://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript" charset="utf-8"></script>'
  end
  
  def gpa_range
    grades = [['', nil],
    ["AP Credit",10.0],
    ["A+",4.0],
    ["A",4.0],
    ["A-",3.7],
    ["B+",3.3],
    ["B",3.0],
    ["B-",2.7],
    ["C+",2.3],
    ["C",2.0],
    ["C-",1.7],
    ["D+",1.3],
    ["D",1.0],
    ["D-",0.7],
    ["F",0.0]]
    return grades
  end
  
  def custom_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation" onclick="$(this).slideUp();">
      <h2>#{sentence}</h2>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
  
  def status_error_messages!
    return "" if current_applicant.errors.empty?

    messages = current_applicant.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved_status",
                      :count => current_applicant.errors.count)

    html = <<-HTML
    <div id="error_explanation" onclick="$(this).slideUp();">
      <h2>#{sentence}</h2>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
  
  
  def application_status
    case current_applicant.state
    when 'completed_recommender_info'
      status = "Ready to submit"
      message = "<p>Your application is ready to submit.  Please review your data and click the #{link_to "submit button", submit_application_path } when you are ready to submit your application.</p>"
    when 'submitted'
      status = "Application submitted"
      message = "<p>Your application has been submitted and your recommendation request has been sent. You will receive further updates 
      by email.</p>"
    when 'complete'
      status = "Complete"
      message = "<p>Congratulations, your application is complete. Please check your email for further updates.</p>"
    else
      status = "Incomplete"
      message = "<p><strong>Your application is incomplete due to the errors mentioned above.  It will not be accepted until all of the necessary data has been added."
      message += " Please go back and #{link_to 'edit', edit_applicant_registration_path } your application</strong>.</p>"
    end
    
    html = <<-HTML
    <div id="application_status" class=#{current_applicant.errors.empty? ? "'alert alert-success'" : "'alert alert-error'"}>
      <h3>#{status}</h3>
      #{message}
    </div>
    HTML
    
    html.html_safe
  end

end
