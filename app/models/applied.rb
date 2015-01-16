class Applied < Applicant
  default_scope { with_state([:applied, :completed_personal_info, :completed_academic_info, :completed_recommender_info]) }

end
