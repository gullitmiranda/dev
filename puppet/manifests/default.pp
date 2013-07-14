$user = 'vagrant'
$home = '/home/vagrant'

class update_packages {
  exec { 'apt-get -y update':
    user => 'root',
    path => '/usr/bin'
  }
}
class { 'update_packages': }
