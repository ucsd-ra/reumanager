class Recommender < ActiveRecord::Base
  validates_presence_of       :name, :title, :department, :college, :phone, :email
end
