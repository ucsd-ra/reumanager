module AdminHelper

  def options_for_student_select(collection, value_method, text_method1, text_method2, text_method3, selected = nil )
    options = collection.map do |element|
      [(element.send(text_method1) + ", " + element.send(text_method2) + " - " + element.send(text_method3)), element.send(value_method)]
    end
    options_for_select(options, selected)
  end

	def options_for_application_status
		options = []
		options << ["Accepted", url_for(:action => 'list', :status => "Accept")]
		options << ["In Review", url_for(:action => 'list', :status => "In Review")]
		options << ["Waitlisted", url_for(:action => 'list', :status => "Waitlist")]
		options << ["Rejected", url_for(:action => 'list', :status => "Reject")]
		options << ["Withdrawn", url_for(:action => 'list', :status => 'Withdrawn')]
		options << ["Incomplete", url_for(:action => 'incomplete')]
		options << ["Submitted", url_for(:action => 'submitted')]
		options << ["Complete", url_for(:action => 'complete')]
		options << ["Total", url_for(:action => 'total')]

		case params[:action]
		when "submitted"
			@selected = url_for(:action => 'submitted')
		when "complete"
			@selected = url_for(:action => 'complete')
		when "total"
			@selected = url_for(:action => 'total')
		when "incomplete"
			@selected = url_for(:action => 'incomplete')
		else
			case params[:status]
			when "Accept"
				@selected = url_for(:action => 'list', :status => "Accept")
			when "In Review"
				@selected = url_for(:action => 'list', :status => "In Review")
			when "Waitlist"
				@selected = url_for(:action => 'list', :status => "Waitlist")
			when "Reject"
				@selected = url_for(:action => 'list', :status => "Reject")
			when "Withdrawn"
				@selected = url_for(:action => 'list', :status => "Withdrawn")
			else
				@selected = url_for(:action => 'total')
			end
		end
		
		options_for_select(options, @selected)
	end
	
  def all_students
    @all_students = User.find(:all, :order => 'lastname ASC', :conditions => ['role_id = ?', 2])
  end
  
  def admin_selected_user
    if @user
      return @user.id
    else
      return all_students.first.id
    end
  end
  
end
