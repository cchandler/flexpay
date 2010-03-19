require File.dirname(__FILE__) + '/units_helper'

describe "Recurring pipeline" do
  before(:each) do
  end
  
  it "should generate a pipeline" do
    pipeline = Flexpay::API.new(:access_key => ACCESS_KEY, :secret_key => SECRET_KEY).get_recurring_pipeline
    pipeline.should_not be_nil
  end
  
  it "should respond to all required parameters" do
    pipeline = Flexpay::API.new(:access_key => ACCESS_KEY, :secret_key => SECRET_KEY).get_recurring_pipeline
    
    Flexpay::CobrandingAPI::V2009_01_09::RecurringPipeline::get_required_parameters.each do |p|
      pipeline.should respond_to(p)
    end
  end
  
  it "should correctly build a parameter hash" do
    pipeline = Flexpay::API.new(:access_key => ACCESS_KEY, :secret_key => SECRET_KEY).get_recurring_pipeline
    
    pipeline.callerReference = Time.now.to_i.to_s
    pipeline.transactionAmount = "10"
    pipeline.recurringPeriod = "1 month"
    pipeline.returnURL = "http://127.0.0.1:3000"
    # pipeline.callerKey = "AKIAICO3MHOOXACSG2VQ"
    
    url = pipeline.generate_url
    url.should_not be_empty
  end
  
end