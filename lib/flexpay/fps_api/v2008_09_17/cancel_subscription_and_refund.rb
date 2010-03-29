module Flexpay
  module FpsAPI
    module V2008_09_17
      class CancelSubscriptionAndRefund
        include Flexpay::FpsAPI::V2008_09_17
        include Flexpay::AmazonFPSRequest
      
        required_parameters "CallerReference", "CancelReason", "RefundAmount", "SubscriptionId", "Action", "AWSAccessKeyId", "Timestamp", "Version"
      
        response_parameters :RefundTransactionId => "/'CancelSubscriptionAndRefundResponse'/'CancelSubscriptionAndRefundResult'/'RefundTransactionId'"
      
        def initialize
          self.Action = "CancelSubscriptionAndRefund"
          self.Version = "2008-09-17"
        end
      
      end
    end
  end
end