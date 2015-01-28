class Extra < ActiveRecord::Base
  belongs_to  :user
# removed to preserve form data
 validates_presence_of :mentor1
 validates_presence_of :mentor2
 validates_presence_of :mentor3
 validates_presence_of :personal_statement

  def self.mentor_list
    options = [''],
    ["Lihini Aluwihare"],
    ["Katherine Barbeau"],
    ["Douglas Bartlett"],
    ["Ron Burton"],
    ["Paterno Castillo"],
    ["Dimitri Deheyn"],
    ["William Gerwick"],
    ["Sarah Gille"],
    ["Paul Jensen"],
    ["Tony Koslow"],
    ["Carolyn Kurle"],
    ["Lisa Levin"],
    ["Richard Norris"],
    ["Brian Palenik"],
    ["Stuart Sandin"],
    ["B. Semmens"],
    ["A. Sirovic"],
    ["Jennifer Taylor"],
    ["M. Vernet"],
    ["Other"]
  end

end
