module Photish
  module Gallery
    module Traits
      module Breadcrumbable
        def breadcrumbs
          html = "<ul class=\"breadcrumbs\">"
          parents_and_me.each_with_index do |level, index|
            html << "<li class=\"" << crumb_class(index) << "\">"
            html << "<a href=\"" << level.url << "\">" << level.name << "</a>"
            html << "</li>"
          end
          html << "</ul>"
        end

        def parents_and_me
          @parents_and_me ||= [parent.try(:parents_and_me),
                               self].flatten.compact
        end

        private

        def crumb_class(index)
          crumb_class = 'breadcrumb'
          crumb_class << ' crumb-' << index.to_s
          crumb_class << ' crumb-first' if index == 0
          crumb_class << ' crumb-last' if index == (parents_and_me.count - 1)
          crumb_class << ' crumb-only' if parents_and_me.count == 1
          crumb_class
        end
      end
    end
  end
end
