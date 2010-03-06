$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

gem 'fakeweb', ">= 1.2.8"

require 'ymlp'
require 'spec'
require 'spec/autorun'
require 'fakeweb'

FakeWeb.allow_net_connect = false

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  File.read(file_path)
end
 
def ymlp_base_url(url = "/")
  Regexp.new(Regexp.escape("https://www.ymlp.com/api#{url}"))
end

def stub_request(url, filename)
 FakeWeb.register_uri(:any, ymlp_base_url(url), :body => fixture_file(filename), :content_type => 'application/json')
end

def stub_invalid_login
  FakeWeb.register_uri(:any, 'https://www.ymlp.com/api/Ping?Output=JSON&Username=login&Key=API_KEY', :body => fixture_file('invalid_api_key.json'), :content_type => 'application/json')
end
 
def stub_get(url, filename)
  # FIXME: We have to specify content type, otherwise HTTParty will not parse the 
  # body correctly. Is there any way we can get around this? Or is this a limitation
  # of using FakeWeb?
  options = { :body => fixture_file(filename), :content_type => 'application/json' }
  FakeWeb.register_uri(:get, ymlp_base_url(url), options)
end



Spec::Runner.configure do |config|
  
end
