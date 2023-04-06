# Module 1: Assign static IP and DNS 
# Prompt user for IP address, subnet mask, default gateway, and DNS server 
$IP = Read-Host "Enter IP Address" 
$SubnetMask = Read-Host "Enter CIDR # " 
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

# Import the ActiveDirectory module
Import-Module ActiveDirectory

# Set the path to the CSV file
$csvPath = "C:\Users\Administrator\Downloads\Green Data - Sheet1.csv"

# Read the CSV file and loop through each row
Import-Csv $csvPath | ForEach-Object {

    # Store the user information in variables
    $name = $_.Name
    $firstName = $_.GivenName
    $lastName = $_.Surname
    $title = $_.Title
    $username = $_.samAccountName
    $department = $_.Department

    # Check if the organizational unit exists, create it if it doesn't
    $ou = Get-ADOrganizationalUnit -Filter { Name -eq $department } -ErrorAction SilentlyContinue
    if (!$ou) {
        New-ADOrganizationalUnit -Name $department -Path "DC=corp,DC=greendata,DC=com"
    }

    # Check if the user already exists, create it if it doesn't
    $user = Get-ADUser -Filter { SamAccountName -eq $username } -ErrorAction SilentlyContinue
    if (!$user) {
        New-ADUser `
            -Name $name `
            -GivenName $firstName `
            -Surname $lastName `
            -Title $title `
            -SamAccountName $username `
            -Path “OU=$department,DC=corp,DC=greendata,DC=com”
    }
}
