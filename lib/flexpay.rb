$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'openssl'
require 'net/https'
require 'uri'
require 'date'
require 'base64'

require 'flexpay/request'
require 'flexpay/api_module'

require 'flexpay/cobranding_api/v2009_01_09'
require 'flexpay/fps_api/v2008_09_17'

require 'flexpay/util'
require 'flexpay/exceptions'

module Flexpay
  class API

    API_ENDPOINT = 'https://fps.amazonaws.com/'.freeze
    API_SANDBOX_ENDPOINT = 'https://fps.sandbox.amazonaws.com/'.freeze
    PIPELINE_URL = 'https://authorize.payments.amazon.com/cobranded-ui/actions/start'.freeze
    PIPELINE_SANDBOX_URL = 'https://authorize.payments-sandbox.amazon.com/cobranded-ui/actions/start'.freeze
    API_VERSION = Date.new(2008, 9, 17).to_s.freeze
    SIGNATURE_VERSION = 2.freeze

    attr_reader :access_key
    attr_reader :secret_key
    attr_reader :fps_url
    attr_reader :pipeline_url
    attr_reader :cobranding_version
    attr_reader :fps_version

    def initialize(params)
      @access_key = params[:access_key]
      @secret_key = params[:secret_key]
      @cobranding_version = params[:cobranding_version] || "2009-01-09"
      @fps_version = params[:fps_version] || "2008-09-17"
      
      if params[:sandbox].nil? or params[:sandbox] == true
        @pipeline_url = PIPELINE_SANDBOX_URL
        @fps_url = API_SANDBOX_ENDPOINT
      else
        @pipeline_url = PIPELINE_URL
        @fps_url = API_ENDPOINT
      end

    end
    
    def get_recurring_pipeline
      obj = cobranding_constant_lookup(:RecurringPipeline).new
      supply_defaults_for_pipeline_and_return(obj)
    end
    
    def get_verify_signature
      obj = fps_constant_lookup(:VerifySignature).new
      supply_defaults_for_fps_and_return(obj)
    end
    
    def get_pay
      obj = fps_constant_lookup(:Pay).new
      supply_defaults_for_fps_and_return(obj)
    end
    
    # def version
    #   raise APINotConfigured if @version.nil? || @version.empty?
    #   @version
    # end
    
    def access_key
      raise APINotConfigured if @access_key.nil? || @access_key.empty?
      @access_key
    end
    
    def secret_key
      raise APINotConfigured if @secret_key.nil? || @secret_key.empty?
      @secret_key
    end
    
    private
    
    def cobranding_constant_lookup(sym)
      Flexpay::CobrandingAPI.const_get("V#{@cobranding_version.gsub(/-/,'_')}".to_sym).specific_class(sym)
    end
    
    def fps_constant_lookup(sym)
      Flexpay::FpsAPI.const_get("V#{@fps_version.gsub(/-/,'_')}".to_sym).specific_class(sym)
    end
    
    def supply_defaults_for_pipeline_and_return(obj)
      obj.access_key = @access_key
      obj.secret_key = @secret_key
      obj.endpoint = @pipeline_url
      obj.callerKey = @access_key # The pipeline API uses this alias
      obj
    end
    
    def supply_defaults_for_fps_and_return(obj)
      obj.access_key = @access_key
      obj.secret_key = @secret_key
      obj.endpoint = @fps_url
      obj
    end
    
  end
end
