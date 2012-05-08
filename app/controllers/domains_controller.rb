include ActionView::Helpers::DateHelper

class DomainsController < ApplicationController
  def show
		w = Whois::Client.new
		r = w.query(params[:domain])
		@domain = r.domain
		@free = r.available?
		@expiration = r.expires_on.strftime("%-d %B %Y")
		@time_left = time_ago_in_words(r.expires_on)
		@status = r.status
		@nss = r.nameservers
		@contact = r.registrant_contact
  end

  def new
  end

end
