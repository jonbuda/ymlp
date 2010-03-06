require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "YMLP" do
  before(:all) do
    @ymlp = YMLP.new('login', 'API_KEY')
  end
  
  context "Authorization" do
    it "should throw an error is the API credentials are incorrect" do
      stub_invalid_login
      lambda { @ymlp.ping }.should raise_exception(RuntimeError, "Invalid or missing API key")
    end
    
    after(:each) do
      FakeWeb.clean_registry  
    end
  end
  
  context "Ping" do
    it "should respond to the Ping API method" do      
      @ymlp.should respond_to(:ping)
    end
    
    it "should have a successful response" do
      stub_request('/Ping', 'ping.json')
      @ymlp.ping['Output'].should == "Hello!"
    end
  end
  
  context "Contacts" do
    it "should respond to the all Contacts API methods" do
      ["Contacts.Add",
      "Contacts.Delete",
      "Contacts.Unsubscribe",
      "Contacts.GetContact",
      "Contacts.GetList",
      "Contacts.GetUnsubscribed",
      "Contacts.GetDeleted",
      "Contacts.GetBounced"].each do |method_name|
        @ymlp.should respond_to(method_name.downcase.gsub('.', '_').to_sym)
      end
    end
  end
  
  context "Groups" do
    it "should respond to the all Groups API methods" do
      ["Groups.GetList",
      "Groups.Add",
      "Groups.Delete",
      "Groups.Update",
      "Groups.Empty",
      "Fields.GetList"].each do |method_name|
        @ymlp.should respond_to(method_name.downcase.gsub('.', '_').to_sym)
      end
    end
  end
  
  context "Fields" do
    it "should respond to the all Fields API methods" do
      ["Fields.Add",
      "Fields.Delete",
      "Fields.Update"].each do |method_name|
        @ymlp.should respond_to(method_name.downcase.gsub('.', '_').to_sym)
      end
    end
  end
  
  

end
