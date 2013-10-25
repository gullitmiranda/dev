include_recipe 'apt'
include_recipe 'openssl'

node.set['platform'] = 'ubuntu'

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
node.set['rvm']['user_installs'] = [
  { user: 'vagrant',
    default_ruby: '2.0.0',
    rubies: ['2.0.0', '1.9.3', 'jruby']
  }
]

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

include_recipe 'ark'
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
include_recipe 'rvm::vagrant'
include_recipe 'rvm::user_install'
include_recipe 'heroku-toolbelt'

# Packages
%w(
  build-essential git-core subversion curl autoconf zlib1g-dev libssl-dev
  libreadline6-dev libxml2-dev libyaml-dev libapreq2-dev vim tmux memcached
  imagemagick libmagickwand-dev libxslt1-dev libxml2-dev sphinxsearch
  libsqlite3-dev htop
).each do |package_name|
  package package_name do
    action :install
  end
end

# Dotfiles
git "/home/vagrant/.yadr" do
  repository "https://github.com/akitaonrails/dotfiles.git"
  reference "master"
  action :checkout
end

