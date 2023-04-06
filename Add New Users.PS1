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
