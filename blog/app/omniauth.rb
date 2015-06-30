OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '893453080180-3ft00b5vmnslu5t3sudgkt4v2du2gqop.apps.googleusercontent.com', 
  '8YRneaXhH2spRU_ZpiWk-j5l', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end