require 'openssl'
require 'base64'
require 'uri'

module Flexpay
  class Signature
    def self.generate_signature(http_method, host, request_uri, params, secret_key)
      method = http_method.to_s.upcase

      #Place in canonical order and URI encode
      encoded_data = params.sort.collect {|i| i.join("=") }.join("&")

      data = "#{http_method}\n#{host}\n#{request_uri}\n#{modified_URL_encoding(encoded_data)}"
      digest = OpenSSL::HMAC.digest(OpenSSL::Digest::SHA256.new, secret_key, data)
      Base64.encode64(digest).strip
    end
    
    private
    
    ## These are the modified encoding rules proposed by Amazon. Not quite URL encoding
    def self.modified_URL_encoding(string)
      URI.escape(string).gsub(/\+/, '%20').gsub(/\*/, '%2A').gsub("%7E","~").gsub(/:/,'%3A').gsub(/\//,'%2F').gsub(/,/, '%2C')
    end
    
  end
end