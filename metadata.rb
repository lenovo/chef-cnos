name             'cnos'
maintainer       'Lenovo'
maintainer_email 'cbhagavathip@lenovo.com'
license          'Apache v2.0'
description      'Implements an recipes for managing network resources on Lenovo switches'
version          '1.0'


recipe "configUpload"
This receipe uploads configuration to the switches. 

recipe "configDownload"
This receipe downloads configuration to the switches. The same configuration can be edited/modified and uploaded back using the configUpload recipe

recipe "imgUpload"
This receipe upload new OS image to the switch.

recipe "vlan"
This receipe manages the VLAN (create/delete) provisiong on the switch.

recipe "vlan_intf"
This receipe provides the management of VLAN properties for ethernet and port-channel interfaces.
                 
recipe "ip_intf"
This receipe provides the management of IP interfaces .


