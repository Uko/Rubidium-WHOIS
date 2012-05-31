require 'spec_helper'

describe DomainsController do

  describe "GET 'show'" do
    it "returns http success"
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

end
