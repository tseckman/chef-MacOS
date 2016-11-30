# chef-MacOS

# Setting up Chef-Client on OS X
Note: This assumes you already have a chef server setup

You need the following items in place:

1. Chef-Clent installed on the machine https://downloads.chef.io/chef-client/mac/
2. Xcode Command Line Tools installed on the machine (Available at the apple developer download site)
3. Validation key file
4. a directory called /etc/chef
 1. Also another directory called /etc/chef/trusted_certs (only if you have to include certs to trust your chef server)
5. The /etc/chef directory should have 4 files in it
 1. chef_run.sh (basic chef-client command)
 2. client.rb (all of your client settings including disabling a ohai pligin that has been know to cause issues, Note that serial number works well for node name as that is unique and shouldnt have duplicates in your org)
 3. machine_role.json (specifys your machine role)
 4. validator.pem (your validator key used in the intial run when setting up the node, this is what your server will use to exchange you a client.pem)

The munki script included is basic script to setup the files correctly. You will likely need to add your organization or other specific items to the variables in the top. 
