class stacks::bootstrap (
  $firewall = true,
  $repos    = false,
) {
  
  if $firewall {
    class { '::profiles::firewall': }
  }
  if $repos {
    class { '::profiles::repositories': }
  }
}
