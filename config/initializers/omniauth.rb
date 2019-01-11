OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLECLIENTID'], ENV['GOOGLECLIENTSECRET'], {client_options: {ssl: { verify: !Rails.env.development? }}}
end
