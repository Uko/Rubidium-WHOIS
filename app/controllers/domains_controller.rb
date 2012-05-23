class DomainsController < ApplicationController
  def show
		if params[:zone].nil?
			if params[:domain_request].nil?
				redirect_to :action => :new
			else
				redirect_to "/" << params[:domain_request].split('.').reverse.join('/')
			end
		end
		dns = "#{params[:domain].split('/').reverse.join('.')}.#{params[:zone]}"
		w = Whois::Client.new
		@r = w.query(dns)
		@domain = @r.domain || dns
		@free = @r.available?
		@free_class = @free ? "free" : "taken"
		if not @free 
			@expiration = @r.expires_on.strftime("%-d %B %Y")
			@time_left = time_ago_in_words(@r.expires_on)
			@status = @r.status
			@nss = @r.nameservers
			@contacts =
			{
				"Registrant Contacts" => @r.registrant_contact,
				"Admin Contacts" => @r.admin_contact,
				"Technical Contacts" => @r.technical_contact
			}
		end
  end

  def new
  end

end
