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
  url = "https://www.ymlp.com/api#{url}"
  Regexp.new(Regexp.escape(url))
end
 
def stub_get(url, filename)
  # FIXME: We have to specify content type, otherwise HTTParty will not parse the 
  # body correctly. Is there any way we can get around this? Or is this a limitation
  # of using FakeWeb?
  options = { :body => fixture_file(filename), :content_type => 'application/json' }
  FakeWeb.register_uri(:get, ymlp_base_url(url), options)
end
 
def stub_post(url, filename)
  FakeWeb.register_uri(:post, ymlp_base_url(url), :body => fixture_file(filename), :content_type => 'application/json')
end


Spec::Runner.configure do |config|
  
end
