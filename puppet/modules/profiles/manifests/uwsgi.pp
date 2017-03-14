# == Class: profiles::uwsgi
#
# Profile for uwsgi including plugins.
#
# === Parameters
#
# @param apps
# @param emperor_options
# @param gid
# @param install_pip
# @param install_pyton_dev
# @param package_name
# @param package_ensure
# @param package_provider
# @param plugins
# @param service_ensure
# @param service_enable
# @param service_name
# @param service_provider
# @param socket
# @param uid
#
# === Authors
#
# Marc Lambrichs <marc.lambrichs@gmail.com>
#
# === Copyright
#
# Copyright 2017 Marc Lambrichs, unless otherwise noted
#
class profiles::uwsgi (
  $apps              = {},
  $emperor_options   = {},
  $gid               = 'uwgsi',
  $install_pip       = false,
  $install_pyton_dev = false,
  $package_name      = 'uwsgi',
  $package_ensure    = 'installed',
  $package_provider  = 'yum',
  $plugins           = [],
  $service_ensure    = true,
  $service_enable    = true,
  $service_name      = 'uwsgi-emperor',  
  $service_provider  = 'systemd',
  $socket            = undef,
  $uid               = 'uwgsi',
){

  ### TODO: needs to be in class uwsgi
  package { $plugins:
    ensure => present,
  }

  group { $gid:
    ensure => present,
  } ->

  user { $uid:
    ensure => present,
    shell  => '/sbin/nologin',
  }

  class { uwsgi:
    emperor_options    => $emperor_options,
    install_pip        => $install_pip,
    install_python_dev => $install_python_dev,
    package_name       => $package_name,
    package_ensure     => $package_ensure,
    package_provider   => $package_provider,
    service_enable     => $service_enable,
    service_ensure     => $service_ensure,
    service_provider   => $service_provider,
    socket             => $socket,
  }
  create_resources( 'uwsgi::app', $apps )
}
