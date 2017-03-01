# == Class: profiles::neo4j
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
class profiles::neo4j (
  $dbms_mode                      = 'SINGLE',
  $discovery_advertised_address   = "${::fqdn}:5000",
  $edition                        = 'enterprise',
  $group                          = 'neo4j',
  $initial_discovery_members      = [],
  $install_method                 = 'package',
  $jmx_enable                     = false,
  $manage_repo                    = true,
  $raft_advertised_address        = "${::fqdn}:7000",
  $release_rpm                    = 'stable',
  $release_deb                    = 'stable',
  $transaction_advertised_address = "${::fqdn}:6000",
){

  class { '::neo4j':
    dbms_mode                                        => $dbms_mode,
    causal_clustering_discovery_advertised_address   => $discovery_advertised_address,
    causal_clustering_initial_discovery_members      => $initial_discovery_members,
    causal_clustering_raft_advertised_address        => $raft_advertised_address,
    causal_clustering_transaction_advertised_address => $transaction_advertised_address,
    edition                                          => $edition,
    group                                            => $group,
    install_method                                   => $install_method,
    jmx_enable                                       => $jmx_enable,
    manage_repo                                      => $manage_repo,
    release_deb                                      => $release_deb,
    release_rpm                                      => $release_rpm,
  }

}
