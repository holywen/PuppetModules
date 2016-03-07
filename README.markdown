Puppet Module for the Electric Flow 6.0 installation

NOTE:

This module is now supporting

1) Windows for Server installation
2) Windows, SLES and Ubuntu for Agent installation


The module is installing the Electric Flow Server, the web server and the Repository is three different servers

The Electric Flow version installed it depends on the .exe file included in the files folder

For installation set the variable $ef_install.

$ef_install =  true the module install Electric Flow
$ef_install = false the module uninstall Electric Flow


The Module works best with the Roles/Profiles pattern

The module uses Hiera for getting some of the Parameters values
