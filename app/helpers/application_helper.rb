module ApplicationHelper
	# class SmartLabelFormBuilder < ActionView::Helpers::FormBuilder
	#   def label(method, content_or_options_with_block = nil, options = {}, &block)
	#     if !block_given?
	#       super(method, content_or_options_with_block, options)
	#     else
	#       options = content_or_options_with_block.is_a?(Hash) ? content_or_options_with_block.stringify_keys : {}

	#       @template.content_tag(:label, options, &block)
	#     end
	#   end
	# end

	class FormBuilder 
		def date_select(method, options = {}, html_options = {})
			existing_date = @object.send(method) 
			formatted_date = existing_date.to_date.strftime("%F") if existing_date.present?
			@template.content_tag(:div, :class => "input-group") do    
				text_field(method, :value => formatted_date, :class => "form-control datepicker", :"data-date-format" => "YYYY-MM-DD") +
				@template.content_tag(:span, @template.content_tag(:span, "", :class => "glyphicon glyphicon-calendar") ,:class => "input-group-addon")
			end
		end

		def datetime_select(method, options = {}, html_options = {})
			existing_time = @object.send(method) 
			formatted_time = existing_time.to_time.strftime("%F %I:%M %p") if existing_time.present?
			@template.content_tag(:div, :class => "input-group") do    
				text_field(method, :value => formatted_time, :class => "form-control datetimepicker", :"data-date-format" => "YYYY-MM-DD hh:mm A") +
				@template.content_tag(:span, @template.content_tag(:span, "", :class => "glyphicon glyphicon-calendar") ,:class => "input-group-addon")
			end
		end
	end

end
