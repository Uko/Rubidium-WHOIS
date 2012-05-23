include ActionView::Helpers::DateHelper

module DomainsHelper
	
	def add_list_section(section, data)
		if not data.nil? and not data.empty?
			haml_tag :dt, section
			haml_tag :dd, data
		end
	end
	
	def contact_of_type(type)
		case type
		  when 1
		    "Registrant"
		  when 2
				"Admin"
			when 3
				"Tech"
		end
	end
	
	def label_type
		@r.available? ? "label-success" : "label-important"
	end
	
	def date_of(ugly_date)
		ugly_date.strftime("%-d %B %Y")
	end
	
	def time_till(date)
		time_ago_in_words(date)
	end
	
end
