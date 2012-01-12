module AcademicRecordsHelper

  def display_transcript_link(record)
    @html = ''
    
    @html = "#{link_to(record.transcript.original_filename, record.transcript.url, :class => 'ss_sprite ss_page_white_acrobat')}"
  end
  
end
