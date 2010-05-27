require 'rest_client'
require 'logger'
require 'cgi'
require 'uri'
require 'hpricot'

module Flexpay
  module Flexpay::AmazonFPSRequest
    
    def self.included(mod)
      mod.class_eval do
        
        @param_list
        @response_parameters
        
        attr_accessor :access_key
        attr_accessor :secret_key
        attr_accessor :endpoint
        
        def self.required_parameters(*params)
          @param_list = params
          params.each do |p|
            attr_accessor p.to_sym
          end
        end
        
        def self.response_parameters(params)
          @response_parameters = {}
          params.each do |k,v|
            @response_parameters[k] = v
          end
        end
        
        def self.get_required_parameters
          @param_list
        end
        
        def self.get_response_parameters
          @response_parameters
        end
      end
    end
    
    def generate_url(signed_request=true)
      params = generate_parameters
      params = sign_parameters(params) if signed_request == true
      
      "#{@endpoint}?#{build_query_string(params)}"
    end
    
    def go!(signed=true)
      url = generate_url(signed)
      
      RestClient.log = Logger.new(STDOUT)
      result = {}

      begin
        RestClient.log.info url
        response = RestClient.get url
      rescue Exception => e
        result["Exception"] = e
        result["Response"] = e.response
        return result
      end
      
      if response.respond_to?(:body)
        doc = Hpricot.XML(response.body)
      else
        doc = Hpricot.XML(response)
      end
      
      self.class.get_response_parameters.each do |k,v|
        result[k] = eval("(doc#{v}).innerHTML")
      end
      result
    end
    
    private
    
    def build_query_string(params)
      params.sort.collect {|i| i.join("=") }.join("&")
    end
    
    def sign_parameters(params)
      ###  Horrible kludge.  TODO Remove
      if params.has_key?("Action")
        params.merge!({"SignatureVersion" => 2.to_s, "SignatureMethod" => "HmacSHA256"})
      else
        params.merge!({"signatureVersion" => 2.to_s, "signatureMethod" => "HmacSHA256"})
      end
      
      u = URI.parse(URI.escape("#{@endpoint}?#{build_query_string(params)}"))
      sig = Flexpay::Signature.generate_signature('GET',u.host,u.path,params, @secret_key)
        
      if params.has_key?("Action") 
        params.merge({"Signature" => CGI.escape(sig)})
      else
        params.merge({"signature" => CGI.escape(sig)})
      end
    end
    
    def generate_parameters
      params = {}
      self.class.get_required_parameters.each do |p|
        val = self.send(p)
        params[p.gsub('_','.')] = val unless val.nil? || ( val.respond_to?(:empty) ? val.empty? : false )
      end
      params
    end
    
  end
end