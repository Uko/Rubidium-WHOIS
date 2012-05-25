class DomainsController < ApplicationController
  def show
		dns = "#{params[:domain].split('/').reverse.join('.')}.#{params[:zone]}"
		w = Whois::Client.new
		@r = w.query(dns)
		@r.domain ||= dns
  end

	def create
		if not params.key? :domain_request or params[:domain_request].blank?
			redirect_to :action => :new
		else
			unless (params[:domain_request].strip =~ /^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}$/ix).nil?
				redirect_to "/domains/" << params[:domain_request].split('.').reverse.join('/')
			else
				flash[:error] = "\"#{params[:domain_request].strip}\" is not a valid domain name"
				redirect_to :action => :new
			end
		end
	end

  def new
  end

end
