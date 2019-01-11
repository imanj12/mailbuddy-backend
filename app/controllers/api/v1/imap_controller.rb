class Api::V1::ImapController < ApplicationController

   def establishConnection
      render json: Imap.establishConnection(request.body.read())
   end

end
