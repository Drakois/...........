# Define folder paths and file names
$folders = @(
    "C:\Program Files (x86)\MTA San Andreas 1.6\MTA",
    "C:\ProgramData\MTA San Andreas All\1.6\temp",
    "C:\ProgramData\MTA San Andreas All\1.6\temp2",
    "C:\ProgramData\MTA San Andreas All\Common\temp",
    "C:\ProgramData\MTA San Andreas All\Common\temp2"
)

$fileName = "FairplayKD.sys"

foreach ($folderPath in $folders) {
    $fullPath = Join-Path -Path $folderPath -ChildPath $fileName

    # Check if the file already exists
    if (Test-Path $fullPath) {
        Remove-Item -Path $fullPath -Force
        Write-Host "$fileName removed from $folderPath"
    }
        # Create an empty file
        New-Item -ItemType File -Path $fullPath -Force

        # Deny write access to the file
        $acl = Get-Acl $fullPath
        $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("Everyone", "WriteData", "Deny")
        $acl.AddAccessRule($rule)
        Set-Acl -Path $fullPath -AclObject $acl

        Write-Host "$fileName denied creation in $folderPath"
    
}