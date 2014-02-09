class Extra < ActiveRecord::Base
  belongs_to  :user
# removed to preserve form data
 validates_presence_of :mentor1
 validates_presence_of :mentor2
 validates_presence_of :mentor3
 validates_presence_of       :personal_statement
  
  def self.mentor_list
    options = [''],
    ["Lihini Aluwihare"]
    ["Andreas Andersson"],
    ["Katherine Barbeau"],
    ["Douglas Bartlett"],
    ["Bianca Brahamsha"],
    ["Ron Burton"],
    ["Paterno Castillo"],
    ["James Day"],
    ["Dimitri Deheyn"],
    ["Amato Evan"],
    ["Jeff Gee"],
    ["William Gerwick"],
    ["Paul Jensen"],
    ["Tony Koslow"],
    ["Carolyn Kurle"],
    ["Lisa Levin"],
    ["Ken Melville"],
    ["Art Miller"],
    ["B. Greg Mitchell"],
    ["Richard Norris"],
    ["Mark Ohman"],
    ["Ana Sirovic"],
    ["Jennifer Smith"],
    ["Jon Shurin"],
    ["Lisa Tauxe"],
    ["Ariane Verdy"],
    ["Other"]
  end
  
end