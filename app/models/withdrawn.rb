class Withdrawn < Applicant
  default_scope { with_state(:withdrawn) }

end