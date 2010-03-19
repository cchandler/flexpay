module Flexpay
  module FpsAPI
    module V2008_09_17
      class VerifySignature
        include Flexpay::FpsAPI::V2008_09_17
        include Flexpay::AmazonFPSRequest
      
        required_parameters "UrlEndPoint", "HttpParameters", "Action", "Version"
      
        response_parameters :VerificationStatus => "/'VerifySignatureResponse'/'VerifySignatureResult'/'VerificationStatus'"
      
        def initialize
          self.Action = "VerifySignature"
          self.Version = "2008-09-17"
        end
      
      end
    end
  end
end