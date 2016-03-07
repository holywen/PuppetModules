# Class: electricflow::artifactrepo::setup
#
# This file manage the setup of the artifact repository and agent only
#
# Parameters:
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#

class electricflow::artifactrepo::setup (

  $ef_install   = $electricflow::params::ef_install,


) inherits ::electricflow::params {


  if $ef_install {

    include ::electricflow::artifactrepo::install

  }

  else {

    include ::electricflow::uninstall

  }

}
