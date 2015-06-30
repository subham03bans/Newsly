OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '893453080180-0jvv698s6lbgfsljthisjjvj77nvruhl.apps.googleusercontent.com', 'ytyNNTdwA8hi3TNYUznrwCTQ', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end