# Copyright (c) 2006 Nick Sieger <nick@nicksieger.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module ActionView # :nodoc:
  class PDFRender
    PAPER = 'Letter'
    include ApplicationHelper

    def initialize(action_view)
      @action_view = action_view
    end

    # Render pdfs
    def render(template, local_assigns = {})
      @action_view.controller.headers["Content-Type"] = 'application/pdf'

      # Include controller variables
      @action_view.controller.instance_variables.each do |v|
        instance_variable_set(v, @action_view.controller.instance_variable_get(v))
      end

      pdf = ::PDF::Writer.new( :paper => PAPER )
      pdf.compressed = true if RAILS_ENV != 'development'
      eval template, nil, "#{@action_view.base_path}/#{@action_view.first_render}.#{@action_view.pick_template_extension(@action_view.first_render)}"

      pdf.render
    end
  end
end
