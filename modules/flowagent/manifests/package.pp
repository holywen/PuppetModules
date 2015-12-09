class flowagent::package {

#
# Install the 32 bit compatibility packages
#
    exec { 'add-i386':
	command => '/usr/bin/dpkg -add-architecture i386',
	unless => '/usr/bin/dpkg --print-foreign-architectures | /bin/grep i386' 
    }
    package { 'lib32bz2-1.0':
	ensure => 'installed',
    } 
    package { 'libuuid1:i386':
	ensure => 'installed',
    } 
}
