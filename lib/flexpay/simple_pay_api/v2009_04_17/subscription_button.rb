module Flexpay
  module SimplePayAPI
    module V2009_04_17
      
      ## This is pseudo-versioned.  Amazon intends for a button to be placed on the webpage
      ## but you can just as easily forward the user programatically.
      
      class SubscriptionButton
        include Flexpay::SimplePayAPI::V2009_04_17
        include Flexpay::AmazonFPSRequest
      
        required_parameters "accessKey", "amount", "description", "recurringFrequency", "returnURL", "immediateReturn"
      
        def initialize
        end
      
      end
    end
  end
end