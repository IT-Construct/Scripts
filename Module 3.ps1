# Module 3: Create OUs and Users
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
