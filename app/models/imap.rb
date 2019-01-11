require 'net/imap'
require 'date'
require 'mail'
require 'json'
class Imap < ApplicationRecord

   # body will be username and password
   def self.establishConnection(body)
      begin
         imap = Net::IMAP.new("imap.gmail.com", 993, true, nil, false)
         imap.login("imanj12@gmail.com", ENV['GMAILPASSWORD'])
      rescue
         return {errors: 'IMAP Connection could not be initiated'}
      end
      Imap.fetchInbox(imap).to_json
   end

   def self.listMailboxes(imap)
      imap.list('', '*')
   end

   def self.fetchInbox(imap)
      # tomorrow = Date.today + 1
      # tomorrow = tomorrow.strftime('')
      imap.select('INBOX')
      uid = imap.uid_search('*')[0]
      msg = imap.uid_fetch(uid, 'RFC822')[0].attr['RFC822']
      mail = Mail.read_from_string(msg)
      mail.html_part.decoded
   end

end
