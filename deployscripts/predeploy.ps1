 #http://www.red-gate.com/products/oracle-development/dlm-automation-suite-for-oracle/walkthrough
$ErrorActionPreference = "Stop"

$password=$OctopusParameters["dbPassword"]
$dbHost = $OctopusParameters["dbServer"]
$OctopusEnvironment = $OctopusParameters["Environment"]
$OctopusReleaseVersion = $OctopusParameters["Version"]

$here = Split-Path $MyInvocation.MyCommand.Definition

$ScoExe = ".\tools\SCO\SCO.exe"

& $ScoExe /source ".\dbscripts{HR}" /target "System/$password@$dbHost/XE{HR}" /scriptfile="updatescript.sql" /report:"predeploy.html"

New-OctopusArtifact -Path ".\predeploy.html" -Name "predeploy.$OctopusEnvironment.$OctopusReleaseVersion.html"
New-OctopusArtifact -Path ".\updatescript.sql" -Name "updatescript.$OctopusEnvironment.$OctopusReleaseVersion.sql"

exit 0