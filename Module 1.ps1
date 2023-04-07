# Module 1: Assign static IP and DNS 
# Prompt user for IP address, subnet mask, default gateway, and DNS server 

$IP = Read-Host "Enter IP Address" 
$SubnetMask = Read-Host "Enter CIDR # " 
$Gateway = Read-Host "Enter Default Gateway" 
$DNS = Read-Host "Enter DNS Server" 

# Set the static IP address and DNS server 
New-NetIPAddress -InterfaceAlias Ethernet -IPAddress $IP -PrefixLength $SubnetMask -DefaultGateway $Gateway 
Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses $DNS 


# This script was created by Lamin Touray
