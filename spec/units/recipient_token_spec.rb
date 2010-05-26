require File.dirname(__FILE__) + '/units_helper'

describe "Recipient token" do
  before(:each) do
  end
  
  it "should respond to all required parameters" do
    pipeline = Flexpay::API.new(:access_key => ACCESS_KEY, :secret_key => SECRET_KEY).get_recipient_token
    
    Flexpay::CobrandingAPI::V2009_01_09::RecipientToken::get_required_parameters.each do |p|
      pipeline.should respond_to(p)
    end
  end
  
  it "should correctly build a parameter hash" do
    pipeline = Flexpay::API.new(:access_key => ACCESS_KEY, :secret_key => SECRET_KEY).get_recipient_token
    
    pipeline.callerReference = Time.now.to_i.to_s
    pipeline.returnURL = "http://127.0.0.1:3000"
    pipeline.callerKey = ACCESS_KEY
    pipeline.recipientPaysFee = true
    
    url = pipeline.generate_url
    url.should_not be_empty
  end
  
end