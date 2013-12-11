include_recipe 'apt'
include_recipe 'openssl'

node.set['platform'] = 'ubuntu'

# sudo
node.set["authorization"]["sudo"] = {
  :users => ["vagrant"],
  :passwordless => true
}

# Apache
node.set['apache'] = {
  :default_site_enabled => true,
  :log_dir => '/www',
  :docroot_dir => '/www'
}

# Postgres
node.set['postgresql'] = {
  :version => "9.3",
  :contrib => {
    :packages => "postgresql-contrib-9.3",
    :extensions => ['hstore']
  },
  :password => {
    :postgres => ''
  },
  :pg_hba => [
    {
      :type => 'local',
      :db => 'all',
      :user => 'postgres',
      :method => 'trust'
    }
  ]
}

# Mysql
node.set['mysql'] = {
  :server_root_password => '',
  :server_repl_password => '',
  :server_debian_password => '',
  :allow_remote_root => true,
  :bind_address => '*',

  :client => {
    :packages => ['libmysqlclient-dev php5-imagick php5-curl php5-mysql php5-mysqlnd']
  }
}

# rvm
node.set['rvm']['installer_url'] = "https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer"
node.set['rvm']['user_installs'] = [ {
  :user => 'vagrant',
  :install_rubies => true,
  :default_ruby => 'ruby-2.0.0-p353'
} ]
node.set['rvm']['vagrant'] = {
  :system_chef_solo => '/usr/local/bin/chef-solo'
}

# Heroku Toolbelt
node.set['heroku-toolbelt']['standalone'] = false

# Mongo DB
node.set[:mongodb] = {
  :version => "2.4.0"
}

# RedisIO
node.set['redis']['source']['version'] = "2.8.2"

# Python
node.set["python"]["install_method"] = "package"

include_recipe 'sudo'
include_recipe 'ark'
include_recipe 'build-essential'
include_recipe 'apache2'
include_recipe 'apache2::mod_php5'
include_recipe 'apache2::mod_rewrite'
include_recipe 'elasticsearch'
include_recipe 'postgresql::server'
include_recipe 'mysql::server'
include_recipe 'mysql::client'
include_recipe 'redis'
include_recipe 'mongodb::10gen_repo'
include_recipe 'mongodb::default'
include_recipe 'python'
include_recipe 'python::pip'
include_recipe 'python::virtualenv'
include_recipe 'nodejs'
include_recipe 'nodejs::npm'
include_recipe 'heroku-toolbelt'
include_recipe 'phantomjs::default'

# Packages
%w(build-essential curl vim git-core git-flow htop imagemagick ruby1.9.3).each do |package_name|
  package package_name do
    action :install
  end
end

include_recipe 'rvm::vagrant'
include_recipe 'rvm::user'

# Dotfiles
execute "install_dotfiles" do
  user "vagrant"
  command 'sh -c "`curl -fsSL https://raw.github.com/gullitmiranda/dotfiles/master/install.sh`"'
end
