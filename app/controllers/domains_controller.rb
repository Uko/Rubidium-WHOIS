class DomainsController < ApplicationController
  def show
		@dns = "#{params[:domain].split('/').reverse.join('.')}.#{params[:zone]}".downcase
		begin
			@record = Whois.query(@dns)
			domains = session[:recent_domains]
			if domains.nil? or domains.empty? or not domains.is_a? Array
				session[:recent_domains] = [@dns]
			else
				domains.delete @dns
				domains.insert 0, @dns
				session[:recent_domains] = domains[0, 10]
			end
		rescue Whois::ConnectionError
			flash[:alert] = "There was a problem with a connection to WHOIS server. Please try again in a moment"
			redirect_to :action => :new, :params => {:domain_request => @dns}
		rescue Timeout::Error
			flash[:alert] = "The WHOIS server was not responding for a long time. Please try again in a moment"
			redirect_to :action => :new, :params => {:domain_request => @dns}
		rescue Whois::ServerNotFound
			flash[:error] = "The domain #{@dns} is illegal or not supported with our service"
			redirect_to :action => :new
		end
  end

	def create
		if not params.key? :domain_request or params[:domain_request].blank?
			redirect_to :action => :new
		else
			domain = params[:domain_request].strip
			unless (domain =~ /^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}$/ix).nil?
				redirect_to "/domains/" << domain.downcase.split('.').reverse.join('/')
			else
				flash[:error] = "\"#{domain}\" is not a valid domain name"
				redirect_to :action => :new, :params => {:domain_request => @dns}
			end
		end
	end

  def new
  end

end
