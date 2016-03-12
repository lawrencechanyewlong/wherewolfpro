
Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, "729115535104-knk1ss64mra6st578k82jh2btkvp3r80.apps.googleusercontent.com", "7rdK62LejYRk3fR9VLsCyJgU", :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}} 

end