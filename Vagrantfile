VAGRANTFILE_API_VERSION = '2'
SYNCED_FOLDER = 'code'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'raring64'
  config.vm.box_url = 'http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box'
  config.vm.host_name = 'brotodevbox'

  config.vm.network :hostonly, '10.10.10.10'

  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.forward_port 3000, 3000
  config.vm.forward_port 4321, 4321

  config.vm.synced_folder "#{ENV['HOME']}/#{SYNCED_FOLDER}", "/home/vagrant/#{SYNCED_FOLDER}"

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '1024']
  end

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = 'cookbooks'
    chef.add_recipe 'main'
  end
end
