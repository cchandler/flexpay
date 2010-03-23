require File.dirname(__FILE__) + '/units_helper'

describe 'Subscription button' do
  before(:each) do
  end
  
  it "should correctly build a request" do
    subscription = Flexpay::API.new(:access_key => ACCESS_KEY, :secret_key => SECRET_KEY).get_subscription_button

    subscription.accessKey = ACCESS_KEY
    subscription.amount = "USD 10"
    subscription.description = "Unit test"
    subscription.recurringFrequency = "1 month"
    subscription.returnURL = "http://localhost:3000"
    
    subscription.generate_url.should_not be_empty
  end
  
end