include_recipe 'apt'
include_recipe 'openssl'

node.set['platform'] = 'ubuntu'

# Postgres
node.set['postgresql'] = {
  version: "9.3",
  enable_pgdg_apt: true,
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
    rubies: ['2.0.0', '1.9.3', '1.8.7', 'jruby', 'rbx']
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

include_recipe 'java'
include_recipe 'postgresql::server'
include_recipe 'mysql::server'
include_recipe 'mysql::client'
include_recipe 'rvm::user_install'
include_recipe 'heroku-toolbelt'

# Packages
%w(
  build-essential git-core subversion curl autoconf zlib1g-dev libssl-dev
  libreadline6-dev libxml2-dev libyaml-dev libapreq2-dev vim tmux memcached
  imagemagick libmagickwand-dev libxslt1-dev libxml2-dev sphinxsearch
  libsqlite3-dev
).each do |package_name|
  package package_name do
    action :install
  end
end

# Dotfiles
bash 'clone dotfiles repo' do
  user 'vagrant'
  cwd '/home/vagrant'
  code 'sh -c "`curl -fsSL https://raw.github.com/skwp/dotfiles/master/install.sh`"'
  not_if { ::File.exists?('/home/vagrant/.yadr') }
end
