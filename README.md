# chef-MacOS

# Setting up Chef-Client on OS X
Note: This assumes you already have a chef server setup

You need the following items in place:

1. Chef-Clent installed on the machine
2. Xcode Command Line Tools installed on the machine 
3. Validation key file
4. a directory called /etc/chef
	a. Also another directory called /etc/chef/trusted_certs (only if you have to include certs to trust your chef server)
5. The /etc/chef directory should have 4 files in it
	a. chef_run.sh (basic chef-client command)
	b. client.rb (all of your client settings including disabling a ohai pligin that has been know to cause issues, Note that serial number works well for node name as that is unique and shouldnt have duplicates in your org)
	c. machine_role.json (specifys your machine role)
	d. validator.pem (your validator key used in the intial run when setting up the node, this is what your server will use to exchange you a client.pem)
