require 'json'
require 'google-api-client'
class Gapi < ApplicationRecord

   def self.fetchData(body)
      client = Signet::OAuth2::Client.new(access_token: ENV['GMAILREFRESHTOKEN'])
      
      service = Google::Apis::GmailV1::GmailService.new
      
      service.authorization = client
      
      service.list_user_labels('me').to_json
   end

end
