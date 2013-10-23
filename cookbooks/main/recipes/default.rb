include_recipe 'apt'
include_recipe 'openssl'
include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

# Postgres configuration
node.set['postgresql']['password']['postgres'] = 'password'
node.set['postgresql']['pg_hba'] = [
  {
    :type => 'local',
    :db => 'all',
    :user => 'postgres',
    :method => 'trust'
  }
]

include_recipe 'postgresql::server'

# Packages
%w(
  build-essential git-core subversion curl autoconf zlib1g-dev libssl-dev
  libreadline6-dev libxml2-dev libyaml-dev libapreq2-dev vim tmux
  imagemagick libmagickwand-dev libxslt1-dev libxml2-dev sphinxsearch
).each do |package_name|
  package package_name do
    action :install
  end
end

# Dotfiles
bash 'clone dotfiles repo' do
  user 'vagrant'
  cwd '/home/vagrant/code'
  code 'git clone https://github.com/brennovich/dotfiles.git /home/vagrant/code/dotfiles'
  not_if { ::File.exists?('/home/vagrant/code') }
end

bash 'install dotfiles' do
  user 'vagrant'
  cwd '/home/vagrant/code/dotfiles'
  code 'rm /home/vagrant/.bashrc && HOME=/home/vagrant sh /home/vagrant/code/dotfiles/install.sh'
  not_if { ::File.exists?('/home/vagrant/.vimrc') }
end

node.default['rbenv']['user_installs'] = [
  { 'user'    => 'vagrant',
    'rubies'  => ['2.0.0-p247'],
    'global'  => '2.0.0-p247',
    'gems'    => {
      '2.0.0-p247'    => [
        { 'name'    => 'bundler' }
      ]
    }
  }
]
