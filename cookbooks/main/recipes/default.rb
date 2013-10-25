include_recipe 'apt'
include_recipe 'openssl'

node.set['platform'] = 'ubuntu'

# Postgres configuration
node.set['postgresql']['password']['postgres'] = 'password'
node.set['postgresql']['pg_hba'] = [
  {
    type: 'local',
    db: 'all',
    user: 'postgres',
    method: 'trust'
  }
]

# rbenv configuration
node.default['rbenv']['user_installs'] = [ { 'user' => 'vagrant' } ]

# Heroku toolbelt configuration
node.set['heroku-toolbelt']['standalone'] = false

include_recipe 'postgresql::server'
include_recipe 'rbenv::user_install'
include_recipe 'ruby_build'
include_recipe 'heroku-toolbelt'

# Packages
%w(
  build-essential git-core subversion curl autoconf zlib1g-dev libssl-dev
  libreadline6-dev libxml2-dev libyaml-dev libapreq2-dev vim tmux memcached
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

bash 'setup neobundle' do
  user 'vagrant'
  cwd '/home/vagrant/'
  code 'git clone git://github.com/Shougo/neobundle.vim /home/vagrant/.vim/bundle/neobundle.vim'
  not_if { ::File.exists?('/home/vagrant/.vim/bundle/neobundle.vim') }
end
