class Recommender < ApplicationRecord
  attr_accessible :department, :email, :first_name, :last_name, :organization, :phone, :title, :url, :id

  has_many :recommendations, :dependent => :destroy
  has_many :applicants, :through => :recommendations

  validates :first_name,  :presence => true
  validates :last_name,   :presence => true
  validates :email,   :presence => true
  validates :organization,   :presence => true
  validates :department,   :presence => true
  validates :title,   :presence => true

  validates_uniqueness_of :email, :message => "must be unique"

  def name
    name = ""
    name += "#{self.first_name} #{self.last_name}"
  end

  def to_s
    recommender = "#{self.name} (#{self.email})<br /> #{self.title}, #{self.department}, #{self.organization}"
  end

  private

  # parse params for existing recommenders and add to array. returns
  # array of existing recommender object and hash with existing
  # recommender attributes removed.
  def self.remove_existing_recommenders_from_params(recommenders_attributes)
    existing_recommenders = find_existing_recommenders(recommenders_attributes)

    recommenders_attributes.to_unsafe_h.map do |r| #TODO lets be safer
      # if the existing recommender is included in the attributes hash
      if existing_recommenders.map(&:email).include?(r[1]['email'])
        # remove the attributes for that recommender unless they include the destroy flag
      # debugger
        recommenders_attributes.delete(r[0]) unless r[1]["_destroy"] == '1'
      end
    end
    [existing_recommenders, recommenders_attributes]
  end

  # parse params and lookup recommenders by email. if they exist, add
  # them to an array.

  def self.find_existing_recommenders(recommenders_attributes)
    existing_recommenders = []
    recommenders_attributes.to_unsafe_h.map do |recommenders_attribute| #TODO lets be safer
      recommender = Recommender.find_by_email(recommenders_attribute[1]['email'])
      existing_recommenders << recommender if recommender != nil
    end

    existing_recommenders
  end

end
