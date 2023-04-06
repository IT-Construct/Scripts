$users = Import-Csv -Path "C:\path\to\file.csv"
foreach ($user in $users) {
    New-ADUser -Name $user.Name -GivenName $user.GivenName -Surname $user.Surname -Title $user.Title -Department $user.Department -SamAccountName $user.samAccountName -Path "OU=$user.Department DC=corp,DC=greendata,DC=com"
}
