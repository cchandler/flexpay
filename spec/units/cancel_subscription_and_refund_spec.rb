require File.dirname(__FILE__) + '/units_helper'

describe 'CancelSubscriptionAndRefund' do
  before(:each) do
  end
  
  it "should correctly build a request" do
    pay = Flexpay::API.new(:access_key => ACCESS_KEY, :secret_key => SECRET_KEY).get_cancel_subscription_and_refund
    
    body =<<HEREDOC 
    <CancelSubscriptionAndRefundResponse 
      xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
      <CancelSubscriptionAndRefundResult>
        <RefundTransactionId>
          14GKE3B85HCMF1BTSH5C4PD2IHZL95RJ2LM
        </RefundTransactionId>
      </CancelSubscriptionAndRefundResult>
      <ResponseMetadata>
        <RequestId>bfbc0b1e-3430-4a74-a75e-5292f59107ca:0</RequestId>
      </ResponseMetadata>
    </CancelSubscriptionAndRefundResponse>
HEREDOC
    
    RestClient.stub!(:get).and_return(body)
    
    # pay.CallerReference = Time.now.to_i.to_s
    # pay.SenderTokenId = "U65I5X19A9HS8DD8MEIH7ASGRQMVTCPNCPKG4ML8Z8NDGGCLU265KXSILUF8SXIA"
    # pay.TransactionAmount_Value = "10"
    # pay.TransactionAmount_CurrencyCode = "USD"
    # pay.AWSAccessKeyId = ACCESS_KEY
    # pay.Timestamp = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")
    
    result = pay.go!
    result.should have_key(:RefundTransactionId)
  end
  
end