# Class: electricflow::agent::setup
#
# This file manage the setup of the  agent only
#
# Parameters:
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#

class electricflow::agent::setup (

  $ef_install   = $electricflow::params::ef_install,


) inherits ::electricflow::params {


  if $ef_install {

    include ::electricflow::agent::install

  }

  else {

    include ::electricflow::uninstall

  }

}
