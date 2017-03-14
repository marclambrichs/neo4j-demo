class profiles::repositories (
  $apt_sources = {},
  $epel        = false,
  $yum_repos   = {},  
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
    'redhat': {
      if $epel {
        class { '::epel': }
        Yumrepo['epel'] -> Package<| |>
      }
      $yum_defaults = {
        enabled  => 1,
        gpgcheck => 1,
      }
      create_resources( 'yumrepo', $yum_repos, $yum_defaults )
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}")
    }
  }
}
