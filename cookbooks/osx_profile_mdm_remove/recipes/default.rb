#
# Cookbook Name:: osx_profile_mdm_remove
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Remove any MDM profiles from Profile Manager

execute "Remove ALL Profiles" do
	command '/bin/echo y|/usr/bin/profiles -D'
	only_if '/usr/bin/profiles -P | /usr/bin/grep com.apple.mdm'
end

execute "Remove ALL Apple Config Profiles" do
        command '/bin/echo y|/usr/bin/profiles -D'
        only_if '/usr/bin/profiles -P | /usr/bin/grep com.apple.config'
end

