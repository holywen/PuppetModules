# Class: electricflow::server::install
#
# This file manage the installation of the server and agent only
#
# Parameters:
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#

class electricflow::server::install (

  $ef_package_name          = $electricflow::params::ef_package_name,
  $ef_exe_path              = $electricflow::params::ef_exe_path,
  $ef_user_name             = $electricflow::params::ef_user_name,
  $ef_user_passwd           = $electricflow::params::ef_user_passwd,
  $ef_remote_server         = $electricflow::params::ef_remote_server,
  $ef_domain                = $electricflow::params::ef_domain,
  $ef_license_path          = $electricflow::params::ef_license_path,
  $ef_license_source_path   = $electricflow::params::ef_license_source_path,
  $temp_path                = $electricflow::params::temp_path,
  $ef_file_replace          = $electricflow::params::ef_file_replace,
  $ef_connect_database      = $electricflow::params::ef_connect_database,
  $ef_database_type         = $electricflow::params::ef_database_type,
  $ef_database_name         = $electricflow::params::ef_database_name,
  $ef_database_hostname     = $electricflow::params::ef_database_hostname,
  $ef_database_port         = $electricflow::params::ef_database_port,
  $ef_database_user_name    = $electricflow::params::ef_database_user_name,
  $ef_database_user_passwd  = $electricflow::params::ef_database_user_passwd,
  $ef_database_dbsetupfile  = $electricflow::params::ef_database_dbsetupfile,
  $ef_admin_user_name       = $electricflow::params::ef_admin_user_name,
  $ef_admin_user_passwd     = $electricflow::params::ef_admin_user_passwd,
  #$ef_database_licenseimportfile  = $electricflow::params::ef_database_licenseimportfile

) inherits ::electricflow::params {

  include electricflow::base
  
  #if (false) {
    notify { 'Start Electric Flow server installation':}
    
    notify { 'Copying the License file':}
    
    file { $ef_license_path:
      ensure   => present,
      replace  => $ef_file_replace ,
      source   => $ef_license_source_path 
    }
    notify { 'License copied':}
  
    file { $ef_database_dbsetupfile:
        ensure   => present,
        content   => template('electricflow/Database_connect.ps1.erb'),
        require => File[$ef_license_path],
        replace  => true   #Always re-generate DB-file
    }
    notify { 'DB generation script copied':}
       
    #Package name must match name in Control Panel --> Programs and Features
    #https://docs.puppetlabs.com/puppet/3.6/reference/resources_package_windows.html#package-name-must-be-the-displayname
    package { $ef_package_name:
        ensure => present,
        provider => windows,
        source => $ef_exe_path,
        install_options => [
        '--mode',
        'silent',
        '--installServer',
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
        '--trustedAgent'
        ],
        require => File[$ef_exe_path],
    }
  #}
  
  
  notify { 'Start setting up the Data base':}
  
  
  #Will only execute if database.properties file does not exist
  exec { $ef_connect_database:
     command   => $ef_database_dbsetupfile,
     creates   => 'C:\ProgramData\Electric Cloud\ElectricCommander\conf\database.properties',
     path      => $::path,
     provider  => powershell,
     timeout   => 6000
  }
  
  ##Delete DB setup file when done
  #exec { 'Delete_dbsetupfile':
  #     command   => "if (Test-Path $ef_database_dbsetupfile) {Remove-Item $ef_database_dbsetupfile -Force}",
  #     path      => $::path,
  #     provider  => powershell
  #}
  
  notify { 'Data base setup done':}
}
