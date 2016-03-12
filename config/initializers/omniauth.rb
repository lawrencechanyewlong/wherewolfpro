Rails.application.config.middleware.use OmniAuth::Builder do
  
  provider :facebook, "981742185206308", "51faff5f3fb13e810e8156a5e575b847", :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}} 
  provider :google_oauth2, "729115535104-knk1ss64mra6st578k82jh2btkvp3r80.apps.googleusercontent.com", "7rdK62LejYRk3fR9VLsCyJgU",:client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}} 
   
end