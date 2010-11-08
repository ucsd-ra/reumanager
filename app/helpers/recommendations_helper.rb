module RecommendationsHelper
  def student_waiver
    if @user.recommender.waive_rights == true
      return "<strong>*The student has <em><u>waived</u></em> his/her right to examine the letter of recommendation.</strong>"
    else
      return "<strong>*The student has <em><u>retained</u></em> his/her right to examine the letter of recommendation.</strong>"
    end
  end
end