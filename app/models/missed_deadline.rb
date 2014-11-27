class MissedDeadline < Applicant
  default_scope { with_state(:incomplete) }

end