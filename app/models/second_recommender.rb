class SecondRecommender < ActiveRecord::Base
  belongs_to  :user
  has_one                     :recommendation
  validates_presence_of       :name, :title, :department, :college, :phone, :email
  validates_format_of         :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  validates_inclusion_of      :waive_rights, :in => [true, false], :on => :create, :message => "must be selected as 'do' or 'do not'"
end
