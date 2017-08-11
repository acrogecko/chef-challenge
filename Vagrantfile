# -*- mode: ruby -*-
# vi: set ft=ruby :

# ---------------------------------------
HOSTNAME = "challenge"
SUBNET = '192.168.3'
SERVER_IP = "#{SUBNET}.10"
SERVER_MEMORY = 2048
# ---------------------------------------

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.cache.auto_detect = true if Vagrant.has_plugin?('vagrant-cachier')

# the virtualbox box with windows installed
#  config.vm.box_url = "file://Win2012R2vag.box"
  config.vm.box = "mwrock/Windows2012R2"

# communicate via winRDP instead of ssh:
  config.vm.communicator = 'winrm'

# Ensure that all networks are set to private
  config.windows.set_work_network = true

  config.vm.define "win", primary: true do |vmconfig|
    # vmconfig.vm.network :private_network, ip: SERVER_IP
    vmconfig.vm.guest = :windows
    # setting of hostname does not work in the vagrant 1.6.3 windows guest
    vmconfig.vm.hostname = 'challenge'
    vmconfig.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
    vmconfig.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
    vmconfig.vm.network :forwarded_port, guest: 80, host: 8080, id: "http", auto_correct: true

    vmconfig.vm.provider :virtualbox do |vb|
      vb.gui = true
      vb.name = HOSTNAME
      vb.customize ["modifyvm", :id, "--memory", SERVER_MEMORY]
    end
  end

  # Chef provisioner
  config.vm.provision "chef_zero" do |chef|
    chef.verbose_logging = true
    chef.cookbooks_path = "chef/cookbooks"
    chef.nodes_path = "chef/nodes"
    # Run list
    chef.add_recipe "challenge_role"
  end

end