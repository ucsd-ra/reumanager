class Extra < ActiveRecord::Base
  belongs_to  :user
# removed to preserve form data
 validates_presence_of :mentor1
 validates_presence_of :mentor2
 validates_presence_of :mentor3
 validates_presence_of       :personal_statement
  
  def self.mentor_list
    options = [''],
    ["Investigating CaCO3 dissolution/dissolution rates in the context of ocean acidification (Prof. Andreas Andersson)"],
    ["Cycling of biologically active trace metals in marine systems (Prof. Katherine Barbeau)"],
    ["Characteristics of microbial communities in deep-ocean trenches (Prof. Douglas Bartlett)"],
    ["Molecular-level examination of the interactions between cyanobacteria and some protozoan predators; investigations of swimming motility in marine cyanobacteria (Dr. Bianca Brahamsha)"],
    ["Evolutionary genetics and molecular ecology of marine organisms (Prof. Ron Burton)"],
    ["Petrology and isotope geochemistry of the post-subduction magnesian andesites from Baja California, Mexico:  Implications for the origin of continental crust (Prof. Paterno Castillo)"],
    ["Terrestrial volcanology and geochemistry (Prof.James Day)"],
    ["Biochemical characterization of light producing compounds (bioluminescence and fluorescence) (Dr. Dimitri Deheyn)"],
    ["Physical science of climate and climate change; the role of aerosols and meteorological clouds (Prof. Amato Evan)"],
    ["Paleomagnetic studies of sedimentary core records from continental margins (Prof. Jeff Gee)"],
    ["Marine Natural Products:  Drug Discovery from Cyanobacteria (Prof. William Gerwick)"],
    ["Marine Microbiology, microbial diversity, drug discovery (Dr. Paul Jensen)"],
    ["California Cooperative Oceanic Fisheries Investigation:  Characterization of the abundance and distribution of micronekton assemblages in the California Current (Dr. Tony Koslow)"],
    ["Tracing pollution in near shore marine systems and examining changes in near shore foodwebs (Prof. Carolyn Kurle)"],
    ["Ecology of coastal and deep sea benthic ecosystems, ecosystem responses to climate change (deoxygenation, acidification) (Prof. Lisa Levin)"],
    ["Physical Oceanography/Air-Sea Interactions (Prof. Ken Melville)"],
    ["Physical oceanography or climate modeling (Dr. Art Miller)"],
    ["Phytoplankton photosynthetic physiology and ecology; Applications of ocean optics and satellite remote sensing in coral reef ecology (Dr. B. Greg Mitchell)"],
    ["Geochemical analysis of marine sediment cores related to climate change and productivity (Prof. Richard Norris)"],
    ["Climate change impacts on the California Current Ecosystem, especially marine zooplankton (Prof. Mark Ohman)"],
    ["Whale acoustics; analyses of long-term Southern California fin whale songs recordings and fin whale song pattern description (Dr. Ana Sirovic)"],
    ["Characteristics of reef growth, coral settlement and community composition across the islands of the central Pacific; responses of marine organisms to ocean acidification/distribution and ecology of invasive seaweeds along the CA coast (Prof. Jennifer Smith)"],
    ["Aquatic Ecosystem Ecology: Intra-specific variation in thermal tolerance of zooplankton collected from the Yosemite lakes/Investigating the effect of sea-level rise on salt marsh communities (Prof. Jon Shurin)"],
    ["Applications of magnetic measurements on local igneous rocks to examine the record of the magnetic field during the Cretaceous (Prof. Lisa Tauxe)"],
    ["Climate Studies: Using observation and numerical model results to analyze the variability of air-sea exchanges of carbon dioxide (CO2) in the California Current Ecosystem.  The goal of this research is to determine the impact of various physical and biological processes on the ocean carbon cycle. (Dr. Ariane Verdy)"]
  end
  
  
end