# Module 1: Assign static IP and DNS 
# Prompt user for IP address, subnet mask, default gateway, and DNS server 
$IP = Read-Host "Enter IP Address" 
$SubnetMask = Read-Host "Enter Subnet Mask" 
$Gateway = Read-Host "Enter Default Gateway" 
$DNS = Read-Host "Enter DNS Server" 
# Set the static IP address and DNS server 
New-NetIPAddress -InterfaceAlias Ethernet -IPAddress $IP -PrefixLength $SubnetMask -DefaultGateway $Gateway 
Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses $DNS 
# Module 2: Rename the Windows Server VM 
# Prompt user for a new name for the Windows Server VM and rename it 
$NewName = Read-Host "Enter a new name for the Windows Server VM" 
Rename-Computer -NewName $NewName -Restart 
# Module 3: Install AD-Domain-Services 
# Install the AD-Domain-Services feature 
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -Restart
Install-WindowsFeature RSAT-AD-Powershell
# Module 4: Create AD Forest, OU, and Users 
# Prompt user for Forest name, OU name and user details 
# Create AD Forest 
Import-Module ADDSDeployment
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainName "corp.greendata.com" `
-DomainNetbiosName "CORP" `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true
# Create new Organizational Units (OU) in AD
New-ADOrganizationalUnit -Name “Engineering” -Path “DC=corp,DC=greendata,DC=com”
# Create new users in AD 
New-Aduser -Name "Jordan Marshall" -GivenName "Jordan" -Surname "Marshall" -SamAccountName "JMarshall" -Title "TPS Reporting Lead" -company "GreenData" -Department "TPS" -EmailAddress "MarshallJordan@greendata.com" -Path “OU=Engineering,DC=corp,DC=greendata,DC=com”
