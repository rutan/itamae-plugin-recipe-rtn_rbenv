# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "sl6"
  config.vm.box_url = 'http://files.rutan.info/box/scientific-6-5-x64-virtualbox.box'

  config.vm.define :user do |c|
    c.vm.network :private_network, ip: '192.168.33.11'
  end
  config.vm.define :system do |c|
    c.vm.network :private_network, ip: '192.168.33.12'
  end
end
