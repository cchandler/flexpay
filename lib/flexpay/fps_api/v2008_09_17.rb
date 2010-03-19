module Flexpay
  module FpsAPI
    module V2008_09_17
      include Flexpay::APIModule
    end
  end
end

require 'flexpay/fps_api/v2008_09_17/verify_signature'
require 'flexpay/fps_api/v2008_09_17/pay'