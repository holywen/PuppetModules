class flowagent::user {

#
# Create the agent user
#
  group {'ecgroup':
    name => $ecgroup,
    ensure => present
  }

  user { 'ecuser' :
    name => $ecuser,
    groups => $ecgroup,
    ensure => present,
    managehome => true,
    shell => '/bin/bash',
    home => '/home/ecuser'
  }
 
}
