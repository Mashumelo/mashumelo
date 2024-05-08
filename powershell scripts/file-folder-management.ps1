<#
.SYNOPSIS
    File/Folder Management
.DESCRIPTION
    This PowerShell script manages files and folders
.PARAMETER sourcePath
    Specifies the source path
.PARAMETER destinationPath
    Specifies the destination path
.PARAMETER zipFileName
    Specifies the zip file name
.EXAMPLE
    PS> .\file-folder-management.ps1
    File/Folder Management
.LINK
    https://github.com/mashumelo/mashumelo
.NOTES
    Author: Waylon Neal
#>

# Prompt the user for the source and destination paths
$sourcePath = Read-Host "Enter the source path"
$destinationPath = Read-Host "Enter the destination path"

# Validate the source path
if (-not (Test-Path -Path $sourcePath -PathType Container)) {
    throw "Source path does not exist or is not a valid directory."
}

# Validate the destination path
if (-not (Test-Path -Path $destinationPath -PathType Container)) {
    throw "Destination path does not exist or is not a valid directory."
}

# Prompt the user for the desired operation
$operation = Read-Host "Enter the operation number (1-5): 1: Copy, 2: Move, 3: Rename, 4: Delete, 5: Zip, 6: Unzip, 7: Exit"

# Validate the operation number
if ($operation -notmatch '^[1-7]$') {
    throw "Invalid operation number. Please enter a number between 1 and 7."
}

try {
# Perform the selected operation
switch ($operation) {
    1 {
        Copy-Item -Path $sourcePath -Destination $destinationPath -Recurse
        "Files copied successfully."
    }
    2 {
        Move-Item -Path $sourcePath -Destination $destinationPath -Recurse
        "Files moved successfully."
    }
    3 {
        $newName = Read-Host "Enter the new name"
        Rename-Item -Path $sourcePath -NewName $newName
        "File or folder renamed successfully."
    }
    4 {
        Remove-Item -Path $sourcePath -Recurse -Confirm:$false
        "Files or folder deleted successfully."
    }
    5 {
        # Prompt the user for the zip file name
        $zipFileName = Read-Host "Enter the zip file name"
        $zipFilePath = "$destinationPath\$zipFileName.zip"
        Compress-Archive -Path $sourcePath -DestinationPath $zipFilePath
        "Files compressed into archive successfully."
    }
    6 {
        $zipFilePath = Read-Host "Enter the path to the ZIP archive"
        Expand-Archive -Path $zipFilePath -DestinationPath $destinationPath
        "Files extracted from archive successfully."
    }
    7 {
        "Exiting..."
        return
    }
    default {
        "Invalid operation number. Exiting..."
        return
        }
    }
} catch {
    "Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
}

# Prompt the user for additional operations
$continue = Read-Host "Do you want to perform another operation? (Y/N)"

# If the user wants to perform another operation, restart the script
if ($continue.ToUpper() -eq "Y") {
    & "C:\path\to\script.ps1"
}