# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def app_navbar
    check_admin ? render(:partial => "layouts/admin_app_navbar") : render(:partial => "layouts/app_navbar")
  end
  
  def toggle_wait_box
    link_to_function("OK", nil, :id => "OK", :class => "padded button") do |page|
      page[:wait_box].toggle
    end
  end
  
  def dynamic_title
    case
    when params[:controller] == "welcome"
      return "<title>UC San Diego, Department of Bioengineering | NSF Research Experience for Undergraduates (NSFREU)</title>"
    when params[:controller] == "projects"
      return "<title>UCSD NSF Research Experience for Undergraduates ::: Projects</title>"
    when params[:controller] == "users" || params[:controller] == "academic_records" || params[:controller] == "extras" || params[:controller] == "recommenders" 
      return "<title>UCSD NSF Research Experience for Undergraduates ::: Application</title>"    
    else
      return "<title>UC San Diego, Department of Bioengineering | NSF Research Experience for Undergraduates (NSFREU)</title>"
    end
  end
  
  def check_admin
    current_user && current_user.role.name == "admin"
  end
  
  def check_academic_records(user)
 #   result = true if user && check_academic_record(user) && check_transcript(user)
  end

  def check_academic_record(user)
  #  result = true if user && user.academic_record
  end
  
  def check_transcript(user)
#    result = true if user && user.academic_record.transcript && user.academic_record.transcript.valid?
  end
  
  def check_pdf(user)
#    unless user.transcript.content_type == "application/pdf" || user.transcript.content_type == "application/octet-stream"
  #    "<p><strong>Your transcript does not appear to be in the PDF format. Please double check your file or perhaps try a different browser and/or computer.</strong></p>"
 #   else
 #     nil
#    end
  end

  def check_recommender(user)
    result = true if user && user.recommender
  end

  def check_recommendation(user)
    result = true if user && user.recommendation
  end

  def check_extras(user)
    result = true if user && user.extra
  end

  def check_all(user)
    result = true if user && check_academic_records(user) && check_recommender(user) && check_extras(user)
  end

  def gpa_range
    gpa_range = ["2.0"]
    float = 2.0
    gpa_range << sprintf("%.1f", float += 0.1) while float < 9.9
    return gpa_range
  end
  
  def disability_selection(user)
    if user && user.disability
      case user.disability
      when nil || ""
        'Prefer\ not\ to\ respond'
      when "No"
        "No"
      else
        "Yes"
      end
    else
      'Prefer\ not\ to\ respond'
    end
  end

end
