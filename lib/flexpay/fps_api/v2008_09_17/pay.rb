module Flexpay
  module FpsAPI
    module V2008_09_17
      class Pay
        include Flexpay::FpsAPI::V2008_09_17
        include Flexpay::AmazonFPSRequest
      
        required_parameters "CallerReference", "SenderTokenId", "TransactionAmount_Value", "TransactionAmount_CurrencyCode", "Action", "AWSAccessKeyId", "Timestamp", "Version"
      
        response_parameters :TransactionId => "/'PayResponse'/'PayResult'/'TransactionId'",
                            :TransactionStatus => "/'PayResponse'/'PayResult'/'TransactionStatus'"
      
        def initialize
          self.Action = "Pay"
          self.Version = "2008-09-17"
        end
      
      end
    end
  end
end