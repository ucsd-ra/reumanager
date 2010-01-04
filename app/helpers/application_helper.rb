# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def gpa_range
    gpa_range = ["2.5"]
    float = 2.5
    gpa_range << sprintf("%.1f", float += 0.1) while float < 9.9
    return gpa_range
  end
  
end
