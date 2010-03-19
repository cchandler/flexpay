require File.dirname(__FILE__) + '/units_helper'

describe Flexpay::Signature do
  before(:each) do
    @api = Flexpay::API.new(:access_key => ACCESS_KEY, :secret_key => SECRET_KEY)
  end
  
  it "should complain if key values aren't specified" do
    @api = Flexpay::API.new(:secret_key => SECRET_KEY)
    lambda { @api.access_key }.should raise_error(APINotConfigured)
    @api = Flexpay::API.new(:access_key => ACCESS_KEY)
    lambda { @api.secret_key }.should raise_error(APINotConfigured)
  end
  
  it "should return a recurring pipeline based on API version" do
    @api.get_recurring_pipeline.should be_a(Flexpay::CobrandingAPI::V2009_01_09::RecurringPipeline)
  end
  
  it "should return a verify signature based on API version" do
    @api.get_verify_signature.should be_a(Flexpay::FpsAPI::V2008_09_17::VerifySignature)
  end
  
end