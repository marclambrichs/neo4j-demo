class graphite_web::install (
  $manage_pkg          = $::graphite_web::manage_pkg,
  $graphite_web_ensure = $::graphite_web::graphite_web_ensure,
  $graphite_web_pkgs   = $::graphite_web::graphite_web_pkgs,
) {

  if $manage_pkg {
    package { $graphite_web_pkgs:
      ensure => $graphite_web_ensure,
    }
  }

}
