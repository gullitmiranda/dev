include_recipe 'apt'
include_recipe 'openssl'

node.set['postgresql']['password']['postgres'] = 'postgres'
node.set['postgresql']['pg_hba'] = [
  {
    :type => 'local',
    :db => 'all',
    :user => 'all',
    :method => 'trust'
  }
]

include_recipe 'postgresql::server'
