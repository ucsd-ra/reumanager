class Recommender < ActiveRecord::Base
  belongs_to  :user
  has_one                     :recommendation
  validates_presence_of       :name, :title, :department, :college, :phone, :email
  validates_format_of         :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
end
