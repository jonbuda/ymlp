require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "YMLP" do
  before(:all) do
    @ymlp = YMLP.new('login', 'API KEY')
  end
  
  context "Ping" do
    it "should have a successful response" do
      stub_post('/Ping', 'ping.json')
      @ymlp.ping['Output'].should == "Hello!"
    end
  end
  
  

end
