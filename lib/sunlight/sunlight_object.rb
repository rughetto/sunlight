module Sunlight
  # Houses general methods to work with the Sunlight and Google Maps APIs
  class SunlightObject
    
    #
    # Takes in a hash where the keys are strings (the format passed in by the JSON parser)
    # if the class does not already have a attr_accessor one is created in the class
    def initialize(params={})
      params.each do |key, value|   
        unless self.class.instance_methods.include?(key) 
          add_accessor( key )
        end
        instance_variable_set("@#{key}", value) 
      end
    end
    
    private 
      def add_accessor( key )
        self.class.class_eval do 
          attr_accessor key.to_sym
        end
      end
    public  
    
    def self.api_url 
      "http://services.sunlightlabs.com/api/"
    end
  
    def self.api_format
      "json"
    end
  
    def self.api_key
      @api_key ||= get_key
    end
    
    def self.api_key=(key)
      @api_key = key
    end  
    
    def self.get_key
      if self == Sunlight::SunlightObject
        File.read( "#{app_root}/config/sunlight.api" )
      else
        Sunlight::SunlightObject.api_key
      end  
    end  
  
    def self.app_root
      defined?(RAILS_ROOT) ? RAILS_ROOT : Merb.root
    end  
  
    # Constructs a Sunlight API-friendly URL
    def self.construct_url(api_method, params)
      "#{api_url}#{api_method}.#{api_format}?apikey=#{api_key}#{hash2get(params)}"
    end
      
    # Converts a hash to a GET string
    def self.hash2get(h)
      get_string = ""
      h.each_pair do |key, value|
        get_string += "&#{key.to_s}=#{CGI::escape(value.to_s)}"
      end
      get_string
    end # def hash2get
  
  
    # Use the Net::HTTP and JSON libraries to make the API call
    #
    # Usage:
    #   District.get_json_data("http://someurl.com")    # returns Hash of data or nil
    def self.get_json_data(url)
      response = Net::HTTP.get_response(URI.parse(url))
      if response.class == Net::HTTPOK
        result = JSON.parse(response.body)
      else
        nil
      end
    end # self.get_json_data
  end # class SunlightObject
end # module Sunlight  