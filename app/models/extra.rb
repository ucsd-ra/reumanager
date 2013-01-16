class Extra < ActiveRecord::Base
  belongs_to  :user
# removed to preserve form data
# validates_presence_of       :personal_statement
end