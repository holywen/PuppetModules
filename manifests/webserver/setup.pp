# Class: electricflow::webserver::setup
#
# This file manage the setup of the webserver and agent only
#
# Parameters:
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#

class electricflow::webserver::setup (

  $ef_install   = $electricflow::params::ef_install,


) inherits ::electricflow::params {


  if $ef_install {

    include ::electricflow::webserver::install

  }

  else {

    include ::electricflow::uninstall

  }

}
