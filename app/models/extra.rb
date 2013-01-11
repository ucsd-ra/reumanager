class Extra < ActiveRecord::Base
  belongs_to  :user
# removed to preserve form data
  validates_presence_of       :project1, :allow_blank => false

  def self.project_options
    options = [''],
    ['Novel Sensors for Structural Health Monitoring – Jennifer Rice'],
    ['Electroceramic Fibers for Smart Composites – Juan Nino'],
    ['Energy Harvesting from Infrastructure Materials – Jacob Jones'],
    ['In situ studies of cement materials using X-ray and neutron scattering techniques- Jacob Jones'],
    ['Self-Healing Materials – Henry Sodano'],
    ['Materials for Energy Harvesting – Henry Sodano'],
    ['Nanofibers for Energy Harvesting – Jennifer Andrew'],
    ['Failure Analysis of Racing Engine Components – Gerhard Fuchs'],
    ['Design and Development of High Performance Shape Memory Alloys – Michele Manuel'],
    ['Engineered Zircaloy Cladding Modifications for Improved Accident Tolerance of LWR (Light Water Reactor) Fuel – Yong Yang'],
    ['Development and testing of pressure sensors for hurricane wind load monitoring – Kurt Gurley']
  end
end