class flowAgent {
    contain flowagent::user
    contain flowagent::package

    file { "/tmp/ElectricFlowAgent-x64-6.0.1.96357":
        mode => "0755",
        source => "puppet:///modules/flowagent/ElectricFlowAgent-x64-6.0.1.96357"
    }

    exec { 'Install ElectricFlow':
      command => "/usr/bin/sudo /tmp/ElectricFlowAgent-x64-6.0.1.96357 --mode silent --unixAgentUser $ecuser --unixAgentGroup $ecgroup",
      creates => '/opt/electriccloud/electriccommander/logs/installer.log',
      returns => 0
    }
}

