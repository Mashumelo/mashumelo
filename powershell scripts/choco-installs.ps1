<#
.SYNOPSIS
    Choco installs (MUST BE RUN AS ADMIN)
.DESCRIPTION
    This PowerShell script installs Choco and packages
.PARAMETER chocoPackages
    Specifies the list of Choco packages to install
.EXAMPLE
    PS> .\choco-installs.ps1
    Install Choco
    Set Choco flag for errors
    Install Choco packages
    Upgrade Choco packages
    Notify you've installed Choco and packages
.LINK
    https://github.com/mashumelo/mashumelo
.NOTES
    Author: Waylon Neal
#>

param(
    [Parameter(Mandatory=$false)]
    [ValidateScript({
        if ($_ -match "^[\w\s;-]+$") {
            $true
        } else {
            throw "Invalid package format. Please provide a semicolon-separated list of package names."
        }
    })]
    [string]$chocoPackages = ""
)

try{
    # Install Choco
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    # Set Choco flag for errors
    choco feature enable --name=stopOnFirstPackageFailure 

    # Set Variable
    if ($chocoPackages -eq "") { $chocoPackages = Read-Host "Enter your Choco packages (e.g. git;vscode) separated by semicolons" }

    # Install Choco packages
    choco install $chocoPackages -y
    if ($lastExitCode -ne "0") { throw "'choco install' command failed with exit code $lastExitCode" }

    # Upgrade Choco packages
    choco upgrade all -y

    "Choco and packages successfully installed!" # Notify you've installed Choco and packages
    exit 0 # success

} catch {
        "Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}