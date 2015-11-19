 #http://www.red-gate.com/products/oracle-development/dlm-automation-suite-for-oracle/walkthrough
$ErrorActionPreference = "Stop"

$password=$OctopusParameters["dbPassword"]
$dbHost = $OctopusParameters["dbServer"]
$OctopusEnvironment = $OctopusParameters["Environment"]
$OctopusReleaseVersion = $OctopusParameters["Version"]
$ScriptFilename = "$OctopusEnvironment.$OctopusReleaseVersion.prescript.sql"
$ReportFilename = "$OctopusEnvironment.$OctopusReleaseVersion.prereport.html"

$here = Split-Path $MyInvocation.MyCommand.Definition

$ScoExe = ".\tools\SCO\SCO.exe"

& $ScoExe /source ".\dbscripts{HR}" /target "System/$password@$dbHost/XE{HR}" /scriptfile=$ScriptFilename /report:$ReportFilename

Write-Output "Schema Compare for Oracle exited with code $lastExitCode"
$ScoExitCode = $lastExitCode

New-OctopusArtifact -Path ".\$ScriptFilename" -Name $ScriptFilename
New-OctopusArtifact -Path ".\$ReportFilename" -Name $ReportFilename

# Exit code 61 is simply telling us there are differences that have been deployed.
if( $ScoExitCode -eq 61)
{
    exit 0
}
