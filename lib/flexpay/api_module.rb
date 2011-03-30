module Flexpay
  module APIModule
    def self.included(mod)
      mod.class_eval do
        @included_in = {}

        def self.included(mod)
          @included_in[mod.to_s.split('::').last.to_sym] = mod
        end

        def self.specific_class(lookup_sym)
          @included_in[lookup_sym]
        end
      end
      
    end
  end
end