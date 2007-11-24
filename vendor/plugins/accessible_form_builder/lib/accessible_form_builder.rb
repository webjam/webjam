# Adds a few helpful methods to the standard form builder to implement Derek
# Featherston's suggestions for accessible forms, which can be found at
# http://simplyaccessible.org
class AccessibleFormBuilder < ActionView::Helpers::FormBuilder
  # Returns a form input label for the given field.
  #
  # Options:
  #
  # <tt>:required</tt>:: Mark as a required field (default: +false+)
  # <tt>:include_error_messages</tt>:: Display error messages related to this particular field (default: +true+)
  #
  # Examples:
  #   <dt><%= f.label :name, :required => true %></dt>
  #   <dd><%= f.text_field :name %></dd>
  #
  #   <dt><%= f.label :company %></dt>
  #   <dd><%= f.text_field :company %></dd>
  #
  #   <dt><%= f.label :state, :required => true, :value => 'State/Province' %></dt>
  #   <dd><%= f.text_field :state %></dd>  
  def label(field, options = {}, html_options = {})
    options = options.reverse_merge(:required => false, :include_error_messages => true)
    value = options.delete(:value) || field.to_s.humanize
    
    html_options.stringify_keys!
    html_options['for'] = "#{@object_name}_#{field}"

    if options[:required]
      value = %Q(<em class="required">* #{value}</em>)
    end

    if options[:include_error_messages] and !@object.errors[field].blank?
      # Include the error messages in the label
      value += %( <em class="error">#{@object.errors[field].to_a.to_sentence}</em>)
      # Add the 'error' class
      html_options['class'] ||= ''
      html_options['class'] += ' ' unless html_options['class'].blank?
      html_options['class'] += 'error'
    end

    @template.content_tag :label, value, html_options
  end
  
  
  # The object's validation messages in readable, sentence form.
  def validation_message
    (@object.errors.on("base").to_a + formatted_attr_error_messages).to_sentence
  end
  
  private
    def formatted_attr_error_messages
      ordered_attr_error_messages.map do |(attr,msg)|
        "<em>" + @object.class.human_attribute_name(attr) + "</em> " + msg
      end
    end
    def ordered_attr_error_messages
      @object.errors.collect {|attr,msg| [attr, msg]}.reject{|a| a[0] == "base"}.sort_by {|a| column_position_of_attribute(a[0].to_s) || ""}
    end
    def column_position_of_attribute(attribute)
      @object.class.columns.map(&:name).index(attribute)
    end
end

module ActionView #:nodoc:
  module Helpers #:nodoc:
    module FormHelper
      # Same as +form_for+ but yields an AccessibleFormBuilder
      def accessible_form_for(object_name, *args, &proc)
        options = args.last.is_a?(Hash) ? args.pop : {}
        options[:builder] = AccessibleFormBuilder
        form_for(object_name, *(args << options), &proc)
      end
      # Same as +fields_for+ but yields an AccessibleFormBuilder
      def accessible_fields_for(object_name, *args, &proc)
        options = args.last.is_a?(Hash) ? args.pop : {}
        options[:builder] = AccessibleFormBuilder
        fields_for(object_name, *(args << options), &proc)    
      end
    end
  end
end