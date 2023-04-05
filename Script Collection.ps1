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
Install-WindowsFeature -Name AD-Domain-Services
# Module 4: Create AD Forest

# Create new Organizational Units (OU) in AD
New-ADOrganizationalUnit -Name “Engineering” -Path “DC=corp,DC=corp.greendata.com”
# Create new users in AD
$securePassword = ConvertTo-SecureString “password” -AsPlainText -Force
New-ADUser -Name “Jordan Marshall” -AccountPassword $securePassword -Path “OU=Engineering,DC=example,DC=com” -Enabled $true
