class Rejected < Applicant
  default_scope { with_state(:rejected) }

end