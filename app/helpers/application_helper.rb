module ApplicationHelper
  
  def errors_for(object, message=nil)
    html = ""
    unless object.errors.blank?
      html << "<div id='error_explanation' onclick='$(this).slideUp();'>\n"
      if message.blank?
        if object.new_record?
          html << "\t\t<h2>There was a problem creating the #{object.class.name.humanize.downcase}</h2>\n"
        else
          html << "\t\t<h2>There was a problem updating the #{object.class.name.humanize.downcase}</h2>\n"
        end    
      else
        html << "<h2>#{message}</h2>"
      end  
      html << "\t\t<ul>\n"
      object.errors.full_messages.each do |error|
        html << "\t\t\t<li>#{error}</li>\n"
      end
      html << "\t\t</ul>\n"
      html << "\t</div>\n"
    end
    raw html
  end  
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields btn btn-mini btn-success", data: {id: id, fields: fields.gsub("\n", "")})
  end
  
  def microsloth_sucks
    html = '<script src="https://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript" charset="utf-8"></script>'
  end
  
end
