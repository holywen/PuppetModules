# electricflow/manifests/params.pp

class electricflow::params {
  #Fact properties
  $ef_domain                = $::domain
  $ef_fqdn                  = $::fqdn
  $ef_operatingsystem       = $::operatingsystem

  $ef_file_replace          = 'no'

  #License
  $ef_license_source_path   = hiera('electricflow::db::licensefile')
  $ef_licensefilename       = hiera('electricflow::licensefilename')

  #Database
  $ef_package_name          = hiera('electricflow::db::package_name')
  $ef_connect_database      = hiera('electricflow::db::connect_database')
  $ef_database_type         = hiera('electricflow::db::database_type')
  $ef_database_name         = hiera('electricflow::db::database_name')
  $ef_database_hostname     = hiera('electricflow::db::database_hostname')
  $ef_database_port         = hiera('electricflow::db::database_port')

  #AOB
  $ef_remote_server         = hiera('electricflow::server')
  $ef_install               = hiera('electricflow::install')

  $ef_admin_user_name       = hiera('electricflow::adminusername')
  $ef_admin_user_passwd     = hiera('electricflow::adminuserpasswd')

  $ef_database_user_name    = hiera('electricflow::db::username')
  $ef_database_user_passwd  = hiera('electricflow::db::userpasswd')


case $ef_operatingsystem  {
  'windows': {

      #parameters
      $temp_path                = 'C:\temp\EF'
      $ef_exe_path              = 'C:\temp\EF\ElectricFlow-6.0.1.96357.exe'
      $ef_source_path           = 'puppet:///modules/electricflow/ElectricFlow-6.0.1.96357.exe'
      $ef_database_dbsetupfile  = 'c:\temp\EF\dbsetup_generated.ps1'
      #$ef_database_licenseimportfile = 'c:\temp\EF\licenseimport_generated.ps1'

      $ef_license_path          = "C:\\temp\\EF\\${ef_licensefilename}"

      $ef_install_folder_1      = 'C:\ProgramData\Electric Cloud'
      $ef_install_folder_2      = 'C:\Program Files\Electric Cloud'

      #Hiera parameters
      $ef_user_name             = hiera('electricflow::username')
      $ef_user_passwd           = hiera('electricflow::userpasswd')

      $ef_creates_file          = undef

      $provider                 = 'windows'

      $ef_install_agent_list_options  = [
      '--mode',
      'silent',
      '--installAgent',
      '--windowsAgentUser',
      $ef_user_name,
      '--windowsAgentDomain',
      $ef_domain,
      '--windowsAgentPassword',
      $ef_user_passwd,
      '--remoteServerDiscoverPlugins',
      '--remoteServer',
      $ef_remote_server,
      '--remoteServerUser',
      $ef_admin_user_name,
      '--remoteServerPassword',
      $ef_admin_user_passwd,
      '--trustedAgent'
      ]

      $ef_uninstall_list_options  = [
      '--mode',
      'silent'
      ]

  }
  /^(SLES|Ubuntu)$/: {

    #parameters
    $temp_path                      = '/tmp/EF'
    $ef_exe_path                    = '/tmp/EF/ElectricFlow-6.0.1.96357'
    $ef_source_path                 = 'puppet:///modules/electricflow/ElectricFlow-6.0.1.96357'

    $ef_license_path                = "/tmp/EF/${ef_licensefilename}"

    $ef_install_folder_1            = '/opt/electriccloud/electriccommander'
    $ef_install_folder_2            = '/opt/electriccloud'

    $pwstate_keyname                = undef

    $ef_user_name                   = pe-puppet
    $ef_user_passwd                 = undef

    $ef_user_group                  = $ef_user_name

    $provider                       = undef

    $ef_creates_file                = '/opt/electriccloud/electriccommander/version'

    $ef_uninstall_file_path         = '/opt/electriccloud/electriccommander/uninstall'


    $ef_install_agent_list_options  = " --mode silent --installAgent --trustedAgent --unixAgentUser ${ef_user_name} --unixAgentGroup ${ef_user_group} --remoteServerDiscoverPlugins --remoteServer ${ef_remote_server} --remoteServerPassword ${ef_admin_user_passwd} --remoteServerUser ${ef_admin_user_name}"

    $ef_uninstall_list_options      = ' --mode silent'


  }
  default: {
    # code
  }
}







}
