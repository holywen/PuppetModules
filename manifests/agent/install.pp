# Class: electricflow::agent::install
#
# This fiel manage the installation of the agent only
#
# Parameters:
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class electricflow::agent::install (

  $ef_package_name                = $electricflow::params::ef_package_name,
  $ef_exe_path                    = $electricflow::params::ef_exe_path,
  $ef_install_provider            = $electricflow::params::provider,
  $ef_install_agent_list_options  = $electricflow::params::ef_install_agent_list_options,
  $ef_operatingsystem             = $electricflow::params::ef_operatingsystem,
  $ef_creates_file                = $electricflow::params::ef_creates_file,
  $ef_user_name                   = $electricflow::params::ef_user_name

) inherits ::electricflow::params {

    include electricflow::base


    notify { 'Start Electric Flow agent installation!!!':}

case $ef_operatingsystem {
  'windows': {
    #Package name must match name in Control Panel --> Programs and Features
    #https://docs.puppetlabs.com/puppet/3.6/reference/resources_package_windows.html#package-name-must-be-the-displayname
      package { $ef_package_name:
          ensure => present,
          provider => $ef_install_provider,
          source => $ef_exe_path,
          install_options => $ef_install_agent_list_options,
          require => File[$ef_exe_path],
        }
      }
    'Ubuntu': {

        $ef_exec_command      = "${ef_exe_path}${ef_install_agent_list_options}"
        $ef_install_exec_name = 'install electric flow'
        $ef_release           = $::operatingsystemmajrelease
        $ef_hardware          = $::hardwaremodel

        user { $ef_user_name:
          ensure  => 'present',
          require => File[$ef_exe_path],
        }

        package { 'lib32bz2-1.0':
          ensure => 'installed',
          require => User[$ef_user_name],
        }

        package { 'libuuid1:i386':
          ensure => 'installed',
          require => Package['lib32bz2-1.0'],
        }


        exec { $ef_install_exec_name:
          command   => "sudo ${ef_exec_command}",
          creates   => $ef_creates_file,
          path      => $::path,
          require => Package['libuuid1:i386'],
        }


    }
    'SLES': {

      $ef_exec_command      = "${ef_exe_path}${ef_install_agent_list_options}"
      $ef_install_exec_name = 'install electric flow'
      $ef_release           = $::operatingsystemmajrelease
      $ef_hardware          = $::hardwaremodel

      user { $ef_user_name:
        ensure  => 'present',
        require => File[$ef_exe_path],
      }

      exec { $ef_install_exec_name:
        command   => "sudo ${ef_exec_command}",
        creates   => $ef_creates_file,
        path      => $::path,
        require => User[$ef_user_name],
      }
    }
  default: {
    # code
  }
}


}
