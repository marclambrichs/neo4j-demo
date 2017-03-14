class profiles::metrics::graphite_web (
  $carbon_caches   = {},
  $database_engine = 'sqlite3',
  $databases       = {},
  $debug           = 'False',
) {

  class { 'graphite_web':
    carbon_caches          => $carbon_caches,
    config_debug           => $debug,
    config_database_engine => $database_engine,
    config_databases       => $databases,
  }
}
