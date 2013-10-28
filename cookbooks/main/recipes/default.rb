include_recipe 'apt'
include_recipe 'openssl'

node.set['platform'] = 'ubuntu'

# sudo
node.set["authorization"]["sudo"] = {
  users: ["vagrant"],
  passwordless: true
}

# Postgres
node.set['postgresql'] = {
  version: "9.3",
  contrib: {
    packages: "postgresql-contrib-9.3"
  },
  password: {
    postgres: ''
  },
  pg_hba: [
    {
      type: 'local',
      db: 'all',
      user: 'postgres',
      method: 'trust'
    }
  ]
}

# Mysql
node.set['mysql'] = {
  server_root_password: '',
  server_repl_password: '',
  server_debian_password: '',
  allow_remote_root: true,
  bind_address: '*',

  client: {
    packages: ['libmysqlclient-dev']
  }
}

# rvm
node.set['rvm']['installer_url'] = "https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer"
node.set['rvm']['user_installs'] = [ {
  user: 'vagrant',
  install_rubies: true,
  default_ruby: 'ruby-2.0.0-p247',
  rubies: ['ruby-1.9.3-p448', 'jruby-1.7.6']
} ]
node.set['rvm']['user_install_rubies'] = true
node.set['rvm']['vagrant'] = {
  system_chef_solo: '/usr/local/bin/chef-solo'
}

# java
node.set['java'] = {
  install_flavor: "oracle",
  jdk_version: 7,
  oracle: {
    accept_oracle_download_terms: true
  }
}

# Heroku Toolbelt
node.set['heroku-toolbelt']['standalone'] = false

# Mongo DB
node.set[:mongodb] = {
  version: "2.4.0"
}

# Python
node.set["python"]["install_method"] = "package"

include_recipe 'sudo'
include_recipe 'ark'
include_recipe 'build-essential'
include_recipe 'java'
include_recipe 'elasticsearch'
include_recipe 'postgresql::server'
include_recipe 'mysql::server'
include_recipe 'mysql::client'
include_recipe 'redisio::install'
include_recipe 'redisio::enable'
include_recipe 'mongodb::10gen_repo'
include_recipe 'mongodb::default'
include_recipe 'python'
include_recipe 'python::pip'
include_recipe 'python::virtualenv'
include_recipe 'nodejs'
include_recipe 'nodejs::npm'
include_recipe 'heroku-toolbelt'

# Packages
%w(
  git-core subversion curl automake autoconf zlib1g zlib1g-dev libssl-dev libreadline6
  libreadline6-dev libxml2-dev libyaml-dev libapreq2-dev vim tmux memcached
  imagemagick libmagickwand-dev libxslt1-dev libxml2-dev sphinxsearch
  libsqlite3-dev htop ncurses-dev libtool ssl-cert pkg-config libgdbm-dev libffi-dev
).each do |package_name|
  package package_name do
    action :install
  end
end

include_recipe 'rvm::vagrant'
include_recipe 'rvm::user'

# Dotfiles
git "/home/vagrant/.yadr" do
  repository "https://github.com/akitaonrails/dotfiles.git"
  reference "master"
  action :checkout
end

