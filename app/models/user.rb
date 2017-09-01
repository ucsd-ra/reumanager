class User < ApplicationRecord
  belongs_to :grant
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable#, :confirmable


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  # attr_accessible :title, :body


  def name
    name = ""
    name += "#{self.first_name} #{self.last_name}"
  end
end
