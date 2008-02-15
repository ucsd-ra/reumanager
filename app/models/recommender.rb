class Recommender < ActiveRecord::Base
  has_many                    :students
  validates_presence_of       :name, :title, :department, :college, :phone, :email
end
