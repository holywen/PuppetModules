# Class: electricflow::agent::uninstall
#
# This file manage the uninstallation of the agent only
#
# Parameters:
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#

class electricflow::uninstall (

  $ef_package_name              = $electricflow::params::ef_package_name,
  $ef_install_folder_1          = $electricflow::params::ef_install_folder_1,
  $ef_install_folder_2          = $electricflow::params::ef_install_folder_2,
  $ef_install_provider          = $electricflow::params::provider,
  $ef_uninstall_list_options    = $electricflow::params::ef_uninstall_list_options,
  $ef_operatingsystem           = $electricflow::params::ef_operatingsystem,
  $ef_uninstall_file_path       = $electricflow::params::ef_uninstall_file_path

) inherits ::electricflow::params {

    notify { 'Remove Electric Flow !!!':}

case $ef_operatingsystem {
  'windows': {
    #Package name must match name in Control Panel --> Programs and Features
    #https://docs.puppetlabs.com/puppet/3.6/reference/resources_package_windows.html#package-name-must-be-the-displayname
    package { $ef_package_name:
        ensure => absent,
        provider => $ef_install_provider,
        uninstall_options => $ef_uninstall_list_options
    }

    notify { 'Remove Electric Flow folders !!!':}

    file {$ef_install_folder_1:
      ensure  => absent,
      path    => $ef_install_folder_1,
      recurse => true,
      purge   => true,
      force   => true,
      require => Package[$ef_package_name],
    }


    file {$ef_install_folder_2:
      ensure  => absent,
      path    => $ef_install_folder_2,
      recurse => true,
      purge   => true,
      force   => true,
      require => Package[$ef_package_name],
    }

  }
  /^(Suse|Debian)$/: {

      $ef_exec_command        = "${ef_uninstall_file_path}${ef_uninstall_list_options}"
      $ef_uninstall_exec_name = 'uninstall electric flow'

      exec { $ef_uninstall_exec_name:
          command   => "sudo ${ef_exec_command}",
          onlyif    => "test -f ${ef_uninstall_file_path}",
          path      => $::path,
        }

      notify { 'Remove Electric Flow folders !!!':}

      file { $ef_install_folder_1:
        ensure  => absent,
        path    => $ef_install_folder_1,
        recurse => true,
        purge   => true,
        force   => true,
        require => Exec[$ef_uninstall_exec_name],
      }


      file { $ef_install_folder_2:
        ensure  => absent,
        path    => $ef_install_folder_2,
        recurse => true,
        purge   => true,
        force   => true,
        require => File[$ef_install_folder_1],
      }
    }
  default: {
    # code
  }
}






}
