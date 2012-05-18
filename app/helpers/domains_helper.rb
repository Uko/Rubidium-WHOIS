module DomainsHelper
	
	def add_list_section(section, data)
		if not data.nil? and not data.empty?
			haml_tag :dt, section
			haml_tag :dd, data
		end
	end
	
	def contacts
		{
			:registrant_contact => "Registrant",
			:admin_contact => "Admin",
			:technical_contact => "Technical"
		}
	end
	
end
