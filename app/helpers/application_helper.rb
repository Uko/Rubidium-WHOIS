module ApplicationHelper
  
  def menu_item (name, of_controller, to_action)
    haml_tag :li, :class => ("active" if controller.controller_name == of_controller && controller.action_name == to_action) do
      haml_concat link_to(name, :controller => of_controller, :action => to_action)
    end
  end
  
  def recent_domains
    domains = session[:recent_domains]
    if domains.nil? or domains.empty? or not domains.is_a? Array
      nil
    else
      domains
    end
  end
  
end
