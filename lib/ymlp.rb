require 'rubygems'
require 'httparty'

class YMLP
  include HTTParty
  base_uri 'https://www.ymlp.com/api'

  def initialize(username, key, format = :json)    
    @base_options = {
      'Username' => username,
      'Key' => key,
      'Output' => format.to_s.upcase
    }
    
    self.class.format format
  end
  
  ["Ping",
  "Contacts.Add",
  "Contacts.Delete",
  "Contacts.Unsubscribe",
  "Contacts.GetContact",
  "Contacts.GetList",
  "Contacts.GetUnsubscribed",
  "Contacts.GetDeleted",
  "Contacts.GetBounced",
  "Groups.GetList",
  "Groups.Add",
  "Groups.Delete",
  "Groups.Update",
  "Groups.Empty",
  "Fields.GetList",
  "Fields.Add",
  "Fields.Delete",
  "Fields.Update"].each do |method_name|
    new_method = <<-method
      def #{method_name.downcase.gsub('.', '_')}(query = {})
        request("/#{method_name}", query)
      end
    method
    
    class_eval( new_method, __FILE__, __LINE__)
  end
  
  private
    
  def request(command, query = {}, method = :get)
    result = self.class.get(command, :query => @base_options.merge(query))

    if result.is_a?(Hash)
      raise(result['Output']) unless result['Code'].to_i == 0    
    end
    
    result
  end

end