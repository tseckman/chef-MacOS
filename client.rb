chef_server_url           "https://chef.YourOrgName.com/organizations/YourOrgName"
validation_client_name    "organization-validator"
validation_key            "/etc/chef/validator.pem"
log_level                 :info
log_location              "/var/log/OSXChef.log"
ssl_ca_path               "/etc/chef/trusted_certs/"
node_name                 'YourNodeNameHere'
environment               'YourEnvironmentName'
ohai.disabled_plugins = [:Passwd]
