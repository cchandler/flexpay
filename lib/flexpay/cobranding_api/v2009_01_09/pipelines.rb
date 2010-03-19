module Flexpay
  module CobrandingAPI
    module V2009_01_09
      class RecurringPipeline
        include Flexpay::CobrandingAPI::V2009_01_09
        include Flexpay::AmazonFPSRequest
      
        required_parameters "pipelineName","callerReference", "recipientToken", "transactionAmount", "recurringPeriod", "returnURL",
            "version", "callerKey"
      
        def initialize
          self.pipelineName = "Recurring"
          self.version = "2009-01-09"
        end
      
      end
    end
  end
end