include_recipe 'apt'
include_recipe 'openssl'
include_recipe 'set_locale'

node.set['postgresql']['password']['postgres'] = 'password'
node['postgresql']['pg_hba'] = [
  {
    :type => 'local',
    :db => 'all',
    :user => 'postgres',
    :method => 'trust'
  }
]

ENV['LANGUAGE'] = ENV['LANG'] = ENV['LC_ALL'] = 'en_US.UTF-8'
include_recipe 'postgresql::server'
