module AdminHelper

  def options_for_student_select(collection, value_method, text_method1, text_method2, selected = nil )
    options = collection.map do |element|
      [(element.send(text_method1) + ", " + element.send(text_method2)), element.send(value_method)]
    end
    options_for_select(options, selected)
  end

  def all_students
    @all_students = User.find(:all, :order => 'lastname ASC')
  end
  
end
