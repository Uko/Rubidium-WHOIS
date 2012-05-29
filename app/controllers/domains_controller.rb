class DomainsController < ApplicationController
  def show
		@dns = "#{params[:domain].split('/').reverse.join('.')}.#{params[:zone]}"
		w = Whois::Client.new
		@r = w.query(@dns)
		domains = session[:recent_domains]
		if domains.nil? or domains.empty? or not domains.is_a? Array
			session[:recent_domains] = [@r.domain]
		else
			domains.delete @r.domain
			domains.insert 0, @r.domain
			session[:recent_domains] = domains[0, 10]
		end
  end

	def create
		if not params.key? :domain_request or params[:domain_request].blank?
			redirect_to :action => :new
		else
			unless (params[:domain_request].strip =~ /^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}$/ix).nil?
				redirect_to "/domains/" << params[:domain_request].downcase.split('.').reverse.join('/')
			else
				flash[:error] = "\"#{params[:domain_request].strip}\" is not a valid domain name"
				redirect_to :action => :new
			end
		end
	end

  def new
  end

end
