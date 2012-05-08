class DomainsController < ApplicationController
  def show
		w = Whois::Client.new
		r = w.query(params[:domain])
		@domain = r.domain
  end

  def new
  end

end
