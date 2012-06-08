require 'spec_helper'

describe DomainsController do

RSpec.configure do |config|
	config.add_setting :domains, :default =>  [
		{
			:plain => 'google.com',
			:path => '/com/google',
			:params => {:zone => 'com', :domain => 'google'}
		},
		{
			:plain => 'google.com.ua',
			:path => '/ua/com/google',
			:params => {:zone => 'ua', :domain => 'com/google'}	
		}
	]
	
end

  describe "show action." do
		
		describe "routing functionality" do
		
			RSpec.configuration.domains.each do |domain|
			
				it "should match /domains#{domain[:path]} as domains#show, zone=>#{domain[:params][:zone]}, domain=>#{domain[:params][:domain]}" do
					{:get => '/domains'+domain[:path]}.should route_to( {:controller => 'domains', :action => 'show'}.merge domain[:params] )
				end
			
			end
			
			it "should not route single words as domain, eg: google" do
				{:get => '/domains/google'}.should_not be_routable
			end
			
		end
		
		RSpec.configuration.domains.each do |domain|
		
			context "#{domain[:plain]} domain" do
			
				before(:each) do
					@record = double("Whois::Record", :domain => domain[:plain])
				end
			
				it "should build '#{domain[:plain]}' from #show, zone=>#{domain[:params][:zone]}, domain=>#{domain[:params][:domain]}" do
					get :show, domain[:params]
					assigns(:dns).should == domain[:plain]
				end
		
				it "should querry '#{domain[:plain]}'" do
					Whois.should_receive(:query).with(domain[:plain])
					get :show, domain[:params]
				end
				
				it "should select a `show` template for renderind" do
					get :show, domain[:params]
					response.should render_template('show')
				end
				
				it "should make a record of '#{domain[:plain]}' availeble for a template" do
					Whois.should_receive(:query).with(domain[:plain]).and_return(@record)
					get :show, domain[:params]
					assigns(:record).should == @record
				end
				
				describe "error handling." do
					
					context "On ConnectionError:" do
						before(:each) do
							Whois.should_receive(:query).and_raise(Whois::ConnectionError)
						end
						
						it "should redirect to domain query" do
							get :show, domain[:params]
							response.should redirect_to(:controller=>'domains', :action => 'new', :params => {:domain_request => domain[:plain]})
						end
						
						it "should flash something" do
							get :show, domain[:params]
							flash[:alert].should == "There was a problem with a connection to WHOIS server. Please try again in a moment"
						end	
					end
					
					context "On Timeout Error:" do
						before(:each) do
							Whois.should_receive(:query).and_raise(Timeout::Error)
						end
						
						it "should redirect to domain query" do
							get :show, domain[:params]
							response.should redirect_to(:controller=>'domains', :action => 'new', :params => {:domain_request => domain[:plain]})
						end
						
						it "should flash something" do
							get :show, domain[:params]
							flash[:alert].should == "The WHOIS server was not responding for a long time. Please try again in a moment"
						end
					end
					
					context "On ServerNotFound:" do
						before(:each) do
							Whois.should_receive(:query).and_raise(Whois::ServerNotFound)
						end
						
						it "should redirect to domain query" do
							get :show, domain[:params]
							response.should redirect_to(:controller=>'domains', :action => 'new')
						end
						
						it "should flash something" do
							get :show, domain[:params]
							flash[:error].should == "The domain #{domain[:plain]} is illegal or not supported with our service"
						end
					end
					
				end
				
			end	
		
		end
		
    it "returns http success"
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

end
