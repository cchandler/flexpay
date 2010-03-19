require File.dirname(__FILE__) + '/units_helper'

describe 'VerifySignature' do
  before(:each) do
  end
  
  it "should correctly build a request" do
    verify = Flexpay::API.new(:access_key => ACCESS_KEY, :secret_key => SECRET_KEY).get_verify_signature
    
    body =<<HEREDOC 
        <VerifySignatureResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
          <VerifySignatureResult>
            <VerificationStatus>Success</VerificationStatus>
          </VerifySignatureResult>
          <ResponseMetadata>
            <RequestId>197e2085-1ed7-47a2-93d8-d76b452acc74:0</RequestId>
          </ResponseMetadata>
        </VerifySignatureResponse>
HEREDOC

    RestClient.stub!(:get).and_return(body)
    
    verify.UrlEndPoint = "http%3A%2F%2Fvamsik.desktop.amazon.com%3A8080%2Fipn.jsp"
    timestamp = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")
    verify.HttpParameters = "expiry%3D08%252F2015%26signature%3DynDukZ9%252FG77uSJVb5YM0cadwHVwYKPMKOO3PNvgADbv6VtymgBxeOWEhED6KGHsGSvSJnMWDN%252FZl639AkRe9Ry%252F7zmn9CmiM%252FZkp1XtshERGTqi2YL10GwQpaH17MQqOX3u1cW4LlyFoLy4celUFBPq1WM2ZJnaNZRJIEY%252FvpeVnCVK8VIPdY3HMxPAkNi5zeF2BbqH%252BL2vAWef6vfHkNcJPlOuOl6jP4E%252B58F24ni%252B9ek%252FQH18O4kw%252FUJ7ZfKwjCCI13%252BcFybpofcKqddq8CuUJj5Ii7Pdw1fje7ktzHeeNhF0r9siWcYmd4JaxTP3NmLJdHFRq2T%252FgsF3vK9m3gw%253D%253D%26signatureVersion%3D2%26signatureMethod%3DRSA-SHA1%26certificateUrl%3Dhttps%253A%252F%252Ffps.sandbox.amazonaws.com%252Fcerts%252F090909%252FPKICert.pem%26tokenID%3DA5BB3HUNAZFJ5CRXIPH72LIODZUNAUZIVP7UB74QNFQDSQ9MN4HPIKISQZWPLJXF%26status%3DSC%26callerReference%3DcallerReferenceMultiUse1&AWSAccessKeyId=AKIAJGC2KB2QP7MVBLYQ&Timestamp=#{timestamp.gsub(':','%3A')}&Version=2008-09-17&SignatureVersion=2&SignatureMethod=HmacSHA256&Signature=fKRGL42K7nduDA47g6bJCyUyF5ZvkBotXE5jVcgyHvE%3D"
    
    result = verify.go!(false)
    result.should have_key(:VerificationStatus)
    result[:VerificationStatus].should == "Success"
  end
  
end