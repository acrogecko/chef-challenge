###########################
# Enable webserver features
###########################

%w{ IIS-WebServerRole IIS-WebServer }.each do |feature|
  windows_feature feature do
    action :install
  end
end

service 'w3svc' do
  action [:start, :enable]
end

##################################
# Retrieve and install the content
##################################

content_project = 'feather'
content_branch = 'master'
content_base = "#{node['iis']['pubroot']}\#{content_project}-#{content_branch}"

windows_zipfile content_base do
  source "https://github.com/colebemis/#{content_project}/archive/#{content_branch}.zip"
  path node['iis']['pubroot']
  action :unzip
end

################
# Setup the site
################

iis_site 'icons' do
  protocol :http
  port 80
  action :add
end

iis_application content_project do
  site_name 'icons'
  path '/'
  physical_path "#{content_base}\icons"
  action :add
end

##########################################
# Enable and setup firewall for web server
##########################################

firewall 'default' do
	action :install
end

firewall_rule 'http' do
  port     80
  protocol :tcp
  command  :allow
end
