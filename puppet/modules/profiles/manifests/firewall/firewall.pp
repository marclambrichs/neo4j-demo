# == Class: profiles::firewall
#
# Full description of class profiles here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'profiles':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class profiles::firewall (
  $server                = true,
  $server_foreman        = false,
  $server_external_nodes = '',
){

  class pre {
    Firewall {
      require => undef
    }

    firewall { '0000 accept all icmp':
      proto  => 'icmp',
      action => 'accept',
    } ->

    firewall { '0001 accept all to lo interface':
      proto   => 'all',
      iniface => 'lo',
      action  => 'accept',
    } ->

    firewall { '0002 accept related established rules':
      proto  => 'all',
      state  => ['RELATED', 'ESTABLISHED'],
      action => 'accept',
    }
  }

  class post {
    Firewall {
      before => undef
    }
   
    firewall { '9998 log packet drops':
      jump       => 'LOG',
      proto      => 'all',
      log_prefix => 'iptables InDrop: ',
      log_level  => 'warn',
    } ->

    firewall { '9999 drop all':
      proto  => 'all',
      action => 'drop',
    }
  }

  class { ['pre', 'post']: } ->
  resources { 'firewall':
    purge => true
  }

  Firewall {
    require => Class['pre'],
    before  => Class['post'],
  }

  firewall { '22-ssh':
    proto  => 'tcp',
    dport  => '22',
    action => 'accept',
  }

}
