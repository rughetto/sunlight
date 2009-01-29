require File.dirname(__FILE__) + '/spec_helper'

describe Sunlight::SunlightObject do
  
  describe "#api_key" do
    it "should load api key from a configuration file in not otherwise defined" do
      RAILS_ROOT = '.'
      Sunlight::SunlightObject.api_key = nil
      Sunlight::SunlightObject.api_key.should == "my_configed_key"
    end  
    
  end  
  
  describe "#hash2get" do
    before(:each) do
      Sunlight::SunlightObject.api_key = 'the_api_key'
      @sunlight = Sunlight::SunlightObject.new
    end
    
    it "should convert a hash to a GET string" do
      get_string = Sunlight::SunlightObject.hash2get(:firstname => "Barack", :lastname => "Obama")
      get_string.should satisfy { |s| s == '&firstname=Barack&lastname=Obama' or s == '&lastname=Obama&firstname=Barack' }
    end
  end
  
  describe "#construct_url" do
    before(:each) do
      Sunlight::SunlightObject.api_key = 'the_api_key'
      @sunlight = Sunlight::SunlightObject.new
    end
    
    it "should construct a properly formatting API URL" do
      Sunlight::SunlightObject.stub!(:hash2get).and_return("&firstname=Nancy&lastname=Pelosi")
    
      url = Sunlight::SunlightObject.construct_url("test.method", {})
      url.should eql( 'http://services.sunlightlabs.com/api/test.method.json?apikey=the_api_key&firstname=Nancy&lastname=Pelosi')
    end
  end
  
  describe "#get_json_data" do
    before(:each) do
      Sunlight::SunlightObject.api_key = 'the_api_key'
      @sunlight = Sunlight::SunlightObject.new
    end
    
    it "should return JSON data from a URL" do
      mock_response = mock Net::HTTPOK
      mock_response.should_receive(:class).and_return(Net::HTTPOK)
      mock_response.should_receive(:body).and_return("{\"response\": {\"districts\": [{\"district\": {\"state\": \"GA\", \"number\": \"6\"}}]}}")
      Net::HTTP.should_receive(:get_response).and_return(mock_response)
    
      data = Sunlight::SunlightObject.get_json_data("http://someurl.com")
      data.should == {"response"=>{"districts"=>[{"district"=>{"number"=>"6","state"=>"GA"}}]}}
    end
  
    it "should return nil when JSON URL returns error code" do
      mock_response = mock Net::HTTPNotFound
      Net::HTTP.should_receive(:get_response).and_return(mock_response)
    
      data = Sunlight::SunlightObject.get_json_data("http://someurl.com")
      data.should be_nil
    end
  end
end