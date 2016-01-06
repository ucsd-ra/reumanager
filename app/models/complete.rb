class Complete < Applicant
  default_scope { with_state(:complete) }

end