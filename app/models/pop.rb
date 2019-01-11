require 'net/pop'
require 'date'
require 'mail'
require 'json'

class Pop < ApplicationRecord

   # def self.initiateDownload(body)
   #    Mail.defaults do
   #       retriever_method :pop3, :address    => "pop.gmail.com",
   #                               :port       => 995,
   #                               :user_name  => 'imanj12@gmail.com',
   #                               :password   => ENV['GMAILPASSWORD'],
   #                               :enable_ssl => false
   #     end
   #     puts Mail.first
   # end
   
   def self.initiateDownload(body)
      begin
         pop = Net::POP3.new('pop.gmail.com')
         pop.enable_ssl(OpenSSL::SSL::VERIFY_NONE)
         pop.start('imanj12@gmail.com', ENV['GMAILPASSWORD'])      
      rescue
         {error: 'POP3 Connection failed'}
      end
      array = []
      puts pop.n_mails
      pop.each_mail do |m|
         array << m.pop('')
      end
      pop.finish
      {msgs: array}
   end

end
