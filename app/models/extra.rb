class Extra < ActiveRecord::Base
  belongs_to  :user
# removed to preserve form data
 validates_presence_of :mentor1
  
  def self.mentor_list
    %w{Lihini\ Aluwihare Douglas\ H.\ Bartlett Katherine\ Barbeau Ron\ Burton Dave\ Checkley James\ Day Dimitri\ Deheyn Andrew\ G.\ Dickson William\ Fenical William\ H.\ Gerwick Sarah\ Gille Lisa\ A.\ Levin Todd\ Martz Richard\ Norris Brian\ Palenik Lynn\ Russell David\ Sandwell Jennifer\ Smith Lisa\ Tauxe Maria\ Vernet Other}
  end
end