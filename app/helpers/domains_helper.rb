module DomainsHelper
	
	def add_list_section(section, data)
		if data
			haml_tag :dt, section
			haml_tag :dd, data
		end
	end
	
end
