require 'cgi'
require 'erb'
require 'set'

module ActionView
  module Helpers
    module TagHelper
      include ERB::Util

      def box_tag(name = 'default', options = nil, &block)
        if name.is_a?(Hash)
          options = name
          name = 'default'
        end
        content = ''
        content += render :partial => "boxes/#{name}_top", :locals => {:options => options}, :layout => false
        content += capture(&block) if block_given?
        content += render :partial => "boxes/#{name}_bottom", :locals => {:options => options}, :layout => false
        
        block_called_from_erb?(block) ? concat(content) : content
      end

    end
  end
end