# A Development environment based on Ruby on Rails devbox

## Introduction

This project automates the setup of a development environment for Ruby on Rails. This is the easiest way to build a box with everything ready to start hacking, all in an isolated virtual machine.

## Requirements

* [VirtualBox](https://www.virtualbox.org)
* [VMWare Fusion (optional)](http://www.vmware.com/products/fusion/)
* [VMWare Provider (optional)](http://www.vagrantup.com/vmware)
* [Vagrant](http://vagrantup.com)

Install Vagrant plugins to make life easier:

    vagrant plugin install vagrant-vbguest
    vagrant plugin install vmware-fusion # (if you bought the license)

## How To Build The Virtual Machine

Building the virtual machine is this easy:

    host $ git clone --recursive https://github.com/gullitmiranda/dev.git ~/dev
    host $ cd dev
    host $ vagrant up

That's it.

NOTE: the folder `./ www` is the default folder for php projects and is mounted inside the VM with the path `/www`.

If the base box is not present that command fetches it first. The setup itself takes about 3 minutes in my MacBook Air. After the installation has finished, you can access the virtual machine with

    host $ vagrant ssh
    Welcome to Ubuntu 12.04.3 LTS (GNU/Linux 3.2.0-23-generic x86_64)
    ...
    vagrant@requestvm:~$

Port 3000 in the host computer is forwarded to port 3000 in the virtual machine. Thus, applications running in the virtual machine can be accessed via localhost:3000 in the host computer.

## What's In The Box

- Git
- RVM with Ruby 2, Ruby 1.9, JRuby 1.7.6
- Postgresql
- Mysql
- Redis
- MongoDB
- Python (with PIP and virtualenv)
- NodeJS
- Elasticsearch
- System dependencies for nokogiri, ruby, rmagick, sqlite3, mysql, mysql2, and pg
- Memcached

## Dotfiles

It installs the awesome [YADR](https://github.com/gullitmiranda/dotfiles) dotfiles. run:

    sh -c "`curl -fsSL https://raw.github.com/gullitmiranda/dotfiles/master/install.sh`"

And to upgrade run:

    cd .dotfiles
    git pull
    rake install

Vagrant is configured to mount your ~/wwww folder within the virtual machine. Change the SYNCED_FOLDER environment variable to choose another folder.

## Virtual Machine Management

When done just log out with `^D` and suspend the virtual machine

    host $ vagrant suspend

then, resume to hack again

    host $ vagrant resume

Run

    host $ vagrant halt

to shutdown the virtual machine, and

    host $ vagrant up

to boot it again.

You can find out the state of a virtual machine anytime by invoking

    host $ vagrant status

Finally, to completely wipe the virtual machine from the disk **destroying all its contents**:

    host $ vagrant destroy # DANGER: all is gone

Please check the [Vagrant documentation](http://docs.vagrantup.com/v2/) for more information on Vagrant.
