module Applicants::RegistrationsHelper
  def only_us_and_ca
    Carmen::Country.all.select{|c| %w{US CA}.include?(c.code)}
  end

  def recommendation_received_label(recommender)
    recommendation = current_applicant.where(:recommender_id => recommender).first
    raw recommendation.valid?  ? " <span class='label label-success'>[RECIEVED]</span>" : " <span class='label label-info'>[NOT RECIEVED]</span> &nbsp;&nbsp;&nbsp; #{ link_to 'Resend Request', applicants_recommendations_request_path(recommender), class: 'btn btn-mini', method: :post}" if current_applicant.submitted?
  end

  def gpa_range
    gpa_range = ["2.0"]
    float = 2.0
    gpa_range << sprintf("%.1f", float += 0.1) while float < 9.9
    return gpa_range
  end

  def gpa_range_by_grade
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

  def show_disability_input?
    current_applicant.disability && current_applicant.disability != 'No' && current_applicant.disability != ''
  end
end

