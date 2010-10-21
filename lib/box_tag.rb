require 'cgi'
require 'erb'
require 'set'

module ActionView
  module Helpers
    module TagHelper
      include ERB::Util

      def box_tag(name = 'default', options = {}, &block)
        if name.is_a?(Hash)
          options = name
          name = 'default'
        end
        content = ''
        content += render :partial => "boxes/#{name}_top", :locals => {:options => options}, :layout => false
        content += capture(&block) if block_given?
        content += render :partial => "boxes/#{name}_bottom", :locals => {:options => options}, :layout => false
        
        if respond_to?('block_called_from_erb?')
          block_called_from_erb?(block) ? concat(content) : content
        else
          content.html_safe
        end
      end

    end
  end
end
