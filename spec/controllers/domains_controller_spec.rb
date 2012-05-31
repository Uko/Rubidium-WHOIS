require 'spec_helper'

describe DomainsController do

  describe "show action." do
	
		describe "routing functionality" do
			
			it "should match /domains/com/google as domains#show, zone=>com, domain=>google" do
				{:get => '/domains/com/google'}.should route_to(
					:controller => 'domains',
					:action => 'show',
					:zone => 'com',
					:domain => 'google'
				)
			end
			
			it "should match /com/ua/google as domains#show, zone=>ua, domain=>com/google" do
				{:get => '/domains/ua/com/google'}.should route_to(
					:controller => 'domains',
					:action => 'show',
					:zone => 'ua',
					:domain => 'com/google'
				)
			end
			
			it "should not route single words as domain, eg: google" do
				{:get => '/domains/google'}.should_not be_routable
			end
			
		end
		
		describe "dns re-building" do
			
			it "should query 'google.com' from #show, zone=>com, domain=>google" do
				get :show, :zone => 'com', :domain => 'google'
				dns = "google.com"
				assigns(:dns).should == dns
			end
			
			it "should query 'google.com.ua' from /ua/com/google" do
				get :show, :zone => 'ua', :domain => 'com/google'
				dns = "google.com.ua"
				assigns(:dns).should == dns
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
