# == Class: stacks::metrics
#
# === Parameters
#
# @param backend_enabled
# @param carbon_caches
# @param carbon_enabled
# @param grafana_enabled
# @param graphite_api_pkg
# @param graphite_interface_enabled
# @param graphite_web_enabled
# @param graphite_web_profile
#
# === Authors
#
# Author Marc Lambrichs <marc.lambrichs@gmail.com>
#
# === Copyright
#
# Copyright 2017 Marc Lambrichs, unless otherwise noted.
#
class stacks::metrics (
  $backend_enabled            = false,
  $carbon_caches              = {},
  $carbon_enabled             = true,
  $grafana_enabled            = false,
  $graphite_api_pkg           = 'graphite-api',
  $graphite_interface_enabled = false,
  $graphite_web_enabled       = false,
  $graphite_web_profile       = 'graphite-web',
){

  if $backend_enabled {
    class { '::profiles::metrics::backend': }
  }

  if $carbon_enabled {
    class { '::profiles::metrics::carbon':
      carbon_caches => $carbon_caches,
    }
  }

  if $grafana_enabled {
    class { '::profiles::metrics::grafana': }
  }

  if $graphite_web_enabled {
    class { '::profiles::metrics::graphite_web':
      carbon_caches => $carbon_caches,
    }
  }

}
