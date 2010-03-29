require File.dirname(__FILE__) + '/units_helper'

describe 'CancelSubscriptionAndRefund' do
  before(:each) do
  end
  
  it "should correctly build a request" do
    pay = Flexpay::API.new(:access_key => ACCESS_KEY, :secret_key => SECRET_KEY).get_cancel_subscription_and_refund
    
    body =<<HEREDOC 
    <PayResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
       <PayResult>
          <TransactionId>14GK6BGKA7U6OU6SUTNLBI5SBBV9PGDJ6UL</TransactionId>
          <TransactionStatus>Pending</TransactionStatus>
       </PayResult>
       <ResponseMetadata>
          <RequestId>c21e7735-9c08-4cd8-99bf-535a848c79b4:0</RequestId>
       </ResponseMetadata>
    </PayResponse>
HEREDOC
    
    RestClient.stub!(:get).and_return(body)
    
    pay.CallerReference = Time.now.to_i.to_s
    pay.SenderTokenId = "U65I5X19A9HS8DD8MEIH7ASGRQMVTCPNCPKG4ML8Z8NDGGCLU265KXSILUF8SXIA"
    pay.TransactionAmount_Value = "10"
    pay.TransactionAmount_CurrencyCode = "USD"
    pay.AWSAccessKeyId = ACCESS_KEY
    pay.Timestamp = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")
    
    result = pay.go!
    result.should have_key(:TransactionId)
    result.should have_key(:TransactionStatus)
  end
  
end