# Class: electricflow::base
#
# This module manages base setup for electric flow
#
# Parameters:
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#


class electricflow::base (

  $temp_path          = $electricflow::params::temp_path,
  $ef_exe_path        = $electricflow::params::ef_exe_path,
  $ef_file_replace    = $electricflow::params::ef_file_replace,
  $ef_source_path     = $electricflow::params::ef_source_path

) inherits ::electricflow::params{

  notify { 'Create Installation Folder!!!': }

  #copy installer
  file { $temp_path:
    ensure => directory
  }

  file { $ef_exe_path:
    ensure   => present,
    replace  => $ef_file_replace ,
    source   => $ef_source_path,
    mode     => '0777',
    require  => File[$temp_path],
  }

}
