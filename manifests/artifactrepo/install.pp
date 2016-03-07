# Class: electricflow::artifactrepo::install
#
# This file manage the installation of the artifact repository and agent only
#
# Parameters:
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#

class electricflow::artifactrepo::install (

  $ef_package_name      = $electricflow::params::ef_package_name,
  $ef_exe_path          = $electricflow::params::ef_exe_path,
  $ef_user_name         = $electricflow::params::ef_user_name,
  $ef_user_passwd       = $electricflow::params::ef_user_passwd,
  $ef_remote_server     = $electricflow::params::ef_remote_server,
  $ef_domain            = $electricflow::params::ef_domain,
  $ef_admin_user_name   = $electricflow::params::ef_admin_user_name,
  $ef_admin_user_passwd = $electricflow::params::ef_admin_user_passwd

) inherits ::electricflow::params {

    include electricflow::base

    notify { 'Start Electric Flow artifact repository installation!!!':}

#Package name must match name in Control Panel --> Programs and Features
#https://docs.puppetlabs.com/puppet/3.6/reference/resources_package_windows.html#package-name-must-be-the-displayname
package { $ef_package_name:
    ensure => present,
    provider => windows,
    source => $ef_exe_path,
    install_options => [
    '--mode',
    'silent',
    '--installRepository',
    '--installAgent',
    '--windowsAgentUser',
    $ef_user_name,
    '--windowsAgentDomain',
    $ef_domain,
    '--windowsAgentPassword',
    $ef_user_passwd,
    '--windowsServerUser',
    $ef_user_name,
    '--windowsServerDomain',
    $ef_domain,
    '--windowsServerPassword',
    $ef_user_passwd,
    '--remoteServerDiscoverPlugins',
    '--remoteServer',
    $ef_remote_server,
    '--remoteServerUser',
    $ef_admin_user_name,
    '--remoteServerPassword',
    $ef_admin_user_passwd,
    '--trustedAgent'
    ],
    require => File[$ef_exe_path],
}

}
