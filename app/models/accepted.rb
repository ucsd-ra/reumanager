class Accepted < Applicant
  default_scope { with_state(:accepted) }

end
