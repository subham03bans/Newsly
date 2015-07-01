OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
#localhost
 provider :google_oauth2, '893453080180-0jvv698s6lbgfsljthisjjvj77nvruhl.apps.googleusercontent.com', 'ytyNNTdwA8hi3TNYUznrwCTQ', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}

# ip
#   provider :google_oauth2, '893453080180-t97cf0krc43pc0oakfgsjuhm35f7ehjm.apps.googleusercontent.com', 'StHYet4Bzq9bdpZ64xiwyWp9', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
 

 #provider :google_oauth2, '893453080180-nbasavho91rv33b60tk35bc9kk7o8045.apps.googleusercontent.com', 'Da4ASkFNOdrObQgchz4elW29', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}


end