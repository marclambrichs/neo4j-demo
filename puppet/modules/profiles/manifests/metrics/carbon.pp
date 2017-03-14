# == Class: profiles::metrics::carbon
#
# Profile for carbon metric solution
#
# === Parameters
#
# @param carbon_cache_enabled
# @param carbon_caches
# @param carbon_ensure
# @param carbon_type
# @param line_receiver_interface
# @param pickle_receiver_interface
# @param protobuf_receiver_enabled
# @param relay_type
# @param udp_listener_enabled
# @param udp_receiver_interface
#
# === Authors
#
# Marc Lambrichs <marc.lambrichs@gmail.com>
#
# === Copyright
#
# Copyright 2016-2017 Marc Lambrichs, unless otherwise noted.
#
class profiles::metrics::carbon (
  $carbon_cache_enabled      = true,
  $carbon_caches             = {},
  $carbon_ensure             = present,
  $carbon_type               = 'carbon',
  $line_receiver_interface   = '0.0.0.0',
  $pickle_receiver_interface = '0.0.0.0',
  $protobuf_receiver_enabled = 'False',
  $relay_type                = 'carbon',
  $udp_listener_enabled      = 'False',
  $udp_receiver_interface    = '0.0.0.0',
) {

  member( ['carbon', 'go-carbon'], $carbon_type )
  member( ['carbon', 'carbon-c-relay'], $relay_type )

  $carbon_relay_enabled = $relay_type ? {
    'carbon' => true,
    default  => false
  }
  
  class { $carbon_type:
    carbon_cache_enabled      => $carbon_cache_enabled,
    carbon_caches             => $carbon_caches,
    carbon_ensure             => $carbon_ensure,
    carbon_relay_enabled      => $carbon_relay_enabled,
    line_receiver_interface   => $line_receiver_interface,
    pickle_receiver_interface => $pickle_receiver_interface,
    protobuf_receiver_enabled => $protobuf_receiver_enabled,
    udp_listener_enabled      => $udp_listener_enabled,
    udp_receiver_interface    => $udp_receiver_interface,
  }
}
