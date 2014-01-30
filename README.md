##winconfig - Windows Configuration Modules
###for use with Puppet Enterprise 3.x

The module will provide parameter-based configuration for managing the state of Windows Server with Puppet Enterprise.  While there are excellent modules that currently exist to manage roles and features, this module will focus on configuring the low level system settings, such as SNMP, UAC and more.

### Available Resources

    winconfig::snmp          - Configure SNMP settings
    winconfig::uac           - Configure UAC settings
    winconfig::searchdomains - Configure DNS search domains
    winconfig::proxy         - Configure Windows Proxy settings

### Dependencies

    > puppet module install puppetlabs-registry
    > puppet module install joshcooper-powershell

### Usage

####winconfig::uac

  **Parameters**
  
  `ensure      => present || absent` - Enable or disable User Account Control (UAC)

####winconfig::snmp

  **Parameters**

  `ensure      => present || absent`   - Enable or disable SNMP Service

  `contact     => <contact info>`      - Contact email address

  `location    => <location info>`     - Location information

  `community   => <community string>`  - Community String

  `destination => <trap server>`       - SNMP Trap Destination Server

####winconfig::searchdomains

  **Parameters**

  `domains => 'example.com,example2.com'` - Comma-Seperated list of domain names

####winconfig::proxy

  **Parameters**

  `ensure        => present || absent`          - Enable or disable proxy

  `proxyserver   => example.com:8080`           - Proxy server URL

  `proxyoverride => example1.com,example2.com`  - Comma-Separated list of domains to bypass proxy
