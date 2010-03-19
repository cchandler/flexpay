require File.dirname(__FILE__) + '/units_helper'

describe Flexpay::Signature do
  before(:each) do
    
  end
  
  it "calculate signatures" do
    
    params = {"Action" => "Pay", "AWSAccessKeyId" => "AKIAIIFXJCFIHITREP4Q", "CallerDescription" => "MyWish",
      "CallerReference" => "CallerReference02", "SenderTokenId" => "553ILMLCG6Z8J431H7BX3UMN3FFQU8VSNTSRNCTAASDJNX66LNZLKSZU3PI7TXIH",
      "SignatureMethod" => "HmacSHA256", "SignatureVersion" => 2, "Timestamp" => "2009-10-06T05%3A49%3A52.843Z",
      "TransactionAmount.CurrencyCode" => "USD", "TransActionAmount.Value" => 1, "Version" => "2008-09-17",}
    
    sig = Flexpay::Signature.generate_signature('GET','fps.sandbox.amazonaws.com',
      'https://fps.sandbox.amazonaws.com',params, SECRET_KEY)
      
    sig.should_not be_empty
  end
end