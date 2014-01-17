class Extra < ActiveRecord::Base
    belongs_to  :user
    validates_presence_of       :personal_statement
end