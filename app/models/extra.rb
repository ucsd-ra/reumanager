class Extra < ActiveRecord::Base
  belongs_to  :user
# removed to preserve form data
  validates_presence_of       :project1, :allow_blank => false

  def self.project_options
    options = [''],
        ['Effect of Moisture Diffusion in Concrete and Epoxy – H.R. Hamilton III'],
        ['Experimental Investigation of the Effect of Surface Markings on the Mechanical Integrity of Weathering Bridge Steels – Michele Manuel'],
        ['Design of Brittle Ductile Laminates for Crack Arresting Structures – Jack Mecholsky'],
        ['Electroceramic Fibers for Smart Composites – Juan Nino'],
        ['Structural Tests on Exterior Corners of Light-Framed Wood Residential Structures – David O. Prevatt'],
        ['Novel Sensors for Structural Health Monitoring – Jennifer Rice'],
        ['Heterogeneous Interface Design – Susan Sinnott'],
        ['Self-Healing Materials – Henry Sodano'],
        ['Flexible Solar Cells for Mobile Infrastructure Monitoring –Xiangeng Xue'],
        ['Engineered Zircaloy Cladding Modifications for Improved Accident Tolerance of LWR (Light Water Reactor) Fuel – Yong Yang']
  end
end