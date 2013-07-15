Vagrant::Config.run do |config|
  config.vm.box       = 'precise64'
  config.vm.box_url   = 'http://files.vagrantup.com/precise64.box'
  config.vm.host_name = 'brotodevbox'

  config.vm.network :hostonly, '10.10.10.10'

  config.vm.forward_port 3000, 3000
  config.vm.forward_port 4321, 4321

  config.vm.share_folder 'code', '/home/vagrant/code', '~/code'

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = 'cookbooks'
    chef.add_recipe 'main'
  end
end
