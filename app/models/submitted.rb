class Submitted < Applicant
  default_scope { with_state(:submitted) }

end