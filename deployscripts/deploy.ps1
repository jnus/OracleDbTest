 #http://www.red-gate.com/products/oracle-development/dlm-automation-suite-for-oracle/walkthrough
$ErrorActionPreference = "Stop"

$password=$OctopusParameters["dbPassword"]
$dbHost = $OctopusParameters["dbServer"]
$OctopusEnvironment = $OctopusParameters["Environment"]
$OctopusReleaseVersion = $OctopusParameters["Version"]

$here = Split-Path $MyInvocation.MyCommand.Definition

$ScoExe = ".\tools\SCO\SCO.exe"

# Deploy changes using Redgate Schema Compare for Oracle
Write-Warning "Upgrading HR"
& $ScoExe /source ".\dbscripts{HR}" /target "System/$password@$dbHost/XE{HR}" -deploy /scriptfile="script.sql" /report:"deploy.html"

Write-Output "Schema Compare for Oracle exited with code $lastExitCode"
$ScoExitCode = $lastExitCode

New-OctopusArtifact -Path ".\deploy.html" -Name "deploy.$OctopusEnvironment.$OctopusReleaseVersion.html"
New-OctopusArtifact -Path ".\script.sql" -Name "script.$OctopusEnvironment.$OctopusReleaseVersion.sql"

# Exit code 61 is simply telling us there are differences that have been deployed.
if( $ScoExitCode -eq 61)
{
    exit 0
}


