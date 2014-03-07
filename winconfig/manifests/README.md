##winconfig - Windows Configuration Modules
###for use with Puppet Enterprise 3.x

The module will provide parameter-based configuration for managing the state of Windows Server with Puppet Enterprise.  While there are excellent modules that currently exist to manage roles and features, this module will focus on configuring the low level system settings, such as SNMP, UAC and more.

### Available Resources

    winconfig::snmp          - Manage SNMP service and settings
    winconfig::uac           - Manage User Account Control settings
	winconfig::esc			 - Manage Internet Explorer Enhanced Security Configuration
	winconfig::rdp			 - Manage RDP services
	winconfig::proxy         - Manage proxy server settings
	winconfig::searchdomains - Add DNS search domains

### Dependencies

This resource type required the Puppet Labs supported `registry` module as well as the powershell module from the Puppet Forge.  They can be installed via Puppet on the command line: 

    [vagrant@master ~] puppet module install puppetlabs-registry
    [vagrant@master ~] puppet module install joshcooper-powershell

### Usage ###

You can use *present* or *enabled* to "turn on" services for most of the resources listed above.  You can use *absent* or *disabled* to "turn them off".  Check the code for use cases.

#### winconfig::uac ####

  **Parameters**
  
	ensure => disabled  # Enable or disable UAC

#### winconfig::esc ####

  **Parameters**

	ensure => disabled	# Enable or disable IE ESC

#### winconfig::rdp ####

  **Parameters**

	ensure => enabled	# Enable Remote Desktop Connections to server

#### winconfig::snmp ####

  **Parameters**

	ensure      => present                  # Enable or disable SNMP Service
	contact     => 'your@contactinfo.com'   # Contact email address
	location    => 'Inside the house'       # Location information
	community   => 'abcxyztotallysecure'    # Community String
	destination => 'trap.server.com'        # SNMP Trap Destination Server

#### winconfig::searchdomains ####

  **Parameters**

	domains => 'example.com,example2.com' # Comma-Seperated list of domain names

#### winconfig::proxy ####

  **Parameters**

	ensure        => present                  # Enable or disable proxy
	proxyserver   => example.com:8080         # Proxy server URL
	proxyoverride => server1.com,server2.com  # Comma-Separated list of domains to bypass proxy

