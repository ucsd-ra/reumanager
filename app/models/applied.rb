class Applied < Applicant
  default_scope { with_state(:applied) }

end