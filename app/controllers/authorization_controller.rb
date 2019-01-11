require 'httparty'                                                             
require 'json'    
require 'devise'    
require 'omniauth-google-oauth2'  
require 'devise_token_auth'                                                                                                        

class AuthorizationController < ApplicationController                              
  include HTTParty
#   include Devise_token_auth

   def get_authorization
      puts 'Request headers Below'
      puts request.headers['Authorization']
      url = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{params["id_token"]}"                  
      response = HTTParty.get(url)       
      puts 'Parsed Response below:'
      puts response.parsed_response            
      @user = User.create_user_for_google(response.parsed_response)      
      tokens = @user.create_new_auth_token                      
      @user.save
      set_headers(tokens)
      render json: { status: 'Signed in successfully with google'}
      # render json:@user # UPDATE THIS RENDER SO IT IS NOT JUST RETURNING ENTIRE USER OBJECT
   end

private                                            
   def set_headers(tokens)
      headers['access-token'] = (tokens['access-token']).to_s
      headers['client'] =  (tokens['client']).to_s
      headers['expiry'] =  (tokens['expiry']).to_s
      headers['uid'] = @user.uid             
      headers['token-type'] = (tokens['token-type']).to_s                  
   end  

end
