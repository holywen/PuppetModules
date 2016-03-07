# Class: electricflow::server::setup
#
# This file manage the setup of th eserver and agent only
#
# Parameters:
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#

class electricflow::server::setup (

  $ef_install   = $electricflow::params::ef_install,


) inherits ::electricflow::params {


  if $ef_install {

    include ::electricflow::server::install

  }

  else {

    include ::electricflow::uninstall

  }

}
