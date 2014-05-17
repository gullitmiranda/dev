VAGRANTFILE_API_VERSION = '2'
SYNCED_FOLDER = ENV['SYNCED_FOLDER'] || "~/www"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Box
  config.vm.box = "requestvm"
  # config.vm.box_url = "/home/requestdev/Downloads/precise64.box"
  # config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.hostname = "requestvm"

  # Network
  config.vm.network :private_network, ip: "192.168.33.33"
  config.vm.synced_folder SYNCED_FOLDER, "/www", umask: 755, nfs: true

  config.vm.network :forwarded_port, guest: 80, host: 8080     # apache/nginx
  config.vm.network :forwarded_port, guest: 1080, host: 1080   # mailcatcher
  config.vm.network :forwarded_port, guest: 1234, host: 1234   # node.js
  config.vm.network :forwarded_port, guest: 3000, host: 3000   # rails
  config.vm.network :forwarded_port, guest: 3306, host: 3306   # mysql
  config.vm.network :forwarded_port, guest: 4567, host: 4567   # sinatra
  config.vm.network :forwarded_port, guest: 5432, host: 5432   # postgres
  config.vm.network :forwarded_port, guest: 6379, host: 6379   # redis
  # config.vm.network :forwarded_port, guest: 8888, host: 8888   # jasmine
  # config.vm.network :forwarded_port, guest: 9090, host: 9090   # debug
  # config.vm.network :forwarded_port, guest: 9292, host: 9292   # rack
  config.vm.network :forwarded_port, guest: 27017, host: 27017   # mongo

  config.vm.provider :virtualbox do |vb|
    # vb.gui = true

    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
  end

  config.vm.provider :vmware_fusion do |v|
    v.vmx["memsize"] = "1024"
  end

  # Provisions
  config.vm.provision :chef_solo do |chef|
    chef.provisioning_path = "/tmp/vagrant-chef-solo"
    chef.file_cache_path = chef.provisioning_path
    chef.cookbooks_path = 'cookbooks'
    chef.add_recipe 'main'
  end
end
