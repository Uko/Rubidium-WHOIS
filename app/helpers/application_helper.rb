module ApplicationHelper
	
	def menu_item	(name, of_controller, to_action)
		haml_tag :li, :class => ("active" if controller.controller_name == of_controller && controller.action_name == to_action) do
			haml_concat link_to(name, :controller => of_controller, :action => to_action)
		end
	end
	
end
