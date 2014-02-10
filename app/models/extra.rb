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
    ["Andreas Andersson"],
    ["Katherine Barbeau"],
    ["Douglas Bartlett"],
    ["Ron Burton"],
    ["Paterno Castillo"],
    ["Dimitri Deheyn"],
    ["Amato Evan"],
    ["William Gerwick"],
    ["Sarah Gille"],
    ["Paul Jensen"],
    ["Tony Koslow"],
    ["Carolyn Kurle"],
    ["Lisa Levin"],
    ["Richard Norris"],
    ["Brian Palenic"],
    ["Lynn Russel"],
    ["Stuart Sandin"],
    ["Lisa Tauxe"],
    ["Jennifer Taylor"],
    ["Other"]
  end
  
end