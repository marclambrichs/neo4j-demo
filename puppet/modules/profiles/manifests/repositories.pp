class profiles::repositories (
  $apt_sources = {},
){

  case $::osfamily {
    'debian': {  
      $apt_defaults = {
        notify => Exec['apt-get-update']
      }

      create_resources( 'apt::source', $apt_sources, $apt_defaults )

      exec { 'apt-get-update':
        command => "/usr/bin/apt-get update",
      }    
    
      class { 'apt':
        purge => {
          purge_sources_list_d => true,
        },
      }

      Exec['apt-get-update'] -> Package <| |>
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}")
    }
  }
}
