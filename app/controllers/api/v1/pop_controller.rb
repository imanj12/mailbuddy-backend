class Api::V1::PopController < ApplicationController

   def initiateDownload
      render json: Pop.initiateDownload(request.body.read())
   end

end
