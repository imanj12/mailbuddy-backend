class Api::V1::GapiController < ApplicationController

   def fetchData
      render json: Gapi.fetchData(request.body.read())
   end

end
