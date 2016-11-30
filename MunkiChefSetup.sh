#!/bin/bash

/bin/mkdir -p /etc/chef/trusted_certs

COMPUTERNAME=`scutil --get ComputerName`
ENVIRONMENT="YourEnvironment"
ChefServerUrl="https://YourDomainName.com/organizations/YourOrgName"
VALIDATOR="YourValidatorName"

#Create the Validation key
if [ ! -f "/etc/chef/validator.pem" ]; then
/bin/cat > /etc/chef/validator.pem <<EOF
-----BEGIN RSA PRIVATE KEY-----
Your client validator key here
-----END RSA PRIVATE KEY-----
EOF
else
  /bin/echo "Machine Validation.pem exists"
fi

# Create the trusted certs dir and load the ca key
if [ ! -f "/etc/chef/trusted_certs/ServerCA.crt" ]; then
/bin/cat > /etc/chef/trusted_certs/ServerCA.crt <<EOF
-----BEGIN CERTIFICATE-----
Yourserver certificate here
-----END CERTIFICATE-----
EOF
else
  /bin/echo "Machine CA cert exists"
fi

#Create the LaunchDaemon File

if [ ! -f "/Library/LaunchDaemons/com.opscode.chef-client.plist" ]; then
/bin/cat > /Library/LaunchDaemons/com.opscode.chef-client.plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.opscode.chef-client</string>
  <key>UserName</key>
  <string>root</string>
  <key>ProgramArguments</key>
          <array>
                <string>/etc/chef/chef_run.sh</string>
          </array>
  <key>StartInterval</key>
         <integer>3600</integer>
  <key>RunAtLoad</key>
  <true/>
</dict>
</plist>
EOF
else
  /bin/echo "Machine launchdaemon exists"
fi

#Create json runlist to call the role of your machines
if [ ! -f "/etc/chef/machine_role.json" ]; then
/bin/cat > /etc/chef/machine_role.json <<EOF
{
  "minimal_ohai" : true,
  "run_list": [
    "role[YourRoleHere]"
  ]
}
EOF
else
  /bin/echo "Machine machine_role.json exists"
fi

#Create the chef_run.sh
if [ ! -f "/etc/chef/chef_run.sh" ]; then
/bin/cat > /etc/chef/chef_run.sh <<EOF
#!/bin/bash
/usr/local/bin/chef-client -j /etc/chef/machine_role.json
EOF
else
  /bin/echo "Machine chef_run.sh exists"
fi

#Create client.rb
if [ $COMPUTERNAME != 'localhost' ]; then
/bin/cat > /etc/chef/client.rb <<EOF
chef_server_url           '$ChefServerUrl'
validation_client_name    '$VALIDATOR'
validation_key            "/etc/chef/validator.pem"
log_level                 :info
ssl_ca_path               "/etc/chef/trusted_certs/"
node_name                 '$COMPUTERNAME'
environment               '$ENVIRONMENT'
ohai.disabled_plugins = [:Passwd]
EOF
else
  /bin/echo "Machine COMPUTERNAME incorrect please set the Computername to something unique and re run the script"
  exit 0
fi

# Set File Permissions for the directory
/bin/chmod -R 640 /etc/chef/*
/usr/sbin/chown -R root:wheel /etc/chef/*

# Set file permissions for the chef_run.sh
/bin/chmod 700 /etc/chef/chef_run.sh

# Load Launch Daemon
/bin/launchctl load -w /Library/LaunchDaemons/com.opscode.chef-client.plist
