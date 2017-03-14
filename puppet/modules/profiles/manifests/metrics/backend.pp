class profiles::metrics::backend (
  $backend_ensure = present,
  $backend_type   = 'whisper',
  $backend_pkg    = 'python-whisper',
  ) {

  member( ['clickhouse', 'influxdb', 'whisper'], $backend_type )    

  package { $backend_type:
    ensure => $backend_ensure,
    name   => $backend_pkg,
  }
}
