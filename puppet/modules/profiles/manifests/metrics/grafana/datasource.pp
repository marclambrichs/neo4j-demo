# == Type profiles::metrics::grafana::datasource
#
# === Parameters
#
# @param access_mode [String]
# @param database [String]
# @param grafana_password [String]
# @param grafana_url [String]
# @param grafana_user [String]
# @param is_default [Boolean]
# @param json_data [String]
# @param password [String]
# @param type [String]
# @param url [String]
# @param user [String]
#
define profiles::metrics::grafana::datasource (
  $access_mode      = undef,
  $database         = undef,
  $grafana_password = undef,
  $grafana_url      = undef,
  $grafana_user     = undef,
  $is_default       = undef,
  $json_data        = undef,
  $password         = undef,
  $type             = undef,
  $url              = undef,
  $user             = undef,
) {

  validate_bool ( $is_default, )

  validate_string(
    $grafana_password,
    $grafana_user,
    $grafana_url,
    $type,
  )

  grafana_datasource { $name:
    access_mode => $access_mode,
    database => $database,
    grafana_password => $grafana_password,
    grafana_url => $grafana_url,
    grafana_user => $grafana_user,
    is_default => $is_default,
    json_data => $json_data,
    password => $password,
    type => $type,
    url => $url,
    user => $user,
  }

}    
