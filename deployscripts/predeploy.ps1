 #http://www.red-gate.com/products/oracle-development/dlm-automation-suite-for-oracle/walkthrough

$password=$OctopusParameters["dbPassword"]
$dbHost = $OctopusParameters["dbServer"]

$ErrorActionPreference = "Stop"
$here = Split-Path $MyInvocation.MyCommand.Definition

$ScoExe = ".\tools\SCO\SCO.exe"

& $ScoExe /source ".\dbscripts{HR}" /target "System/$password@$dbHost/XE{HR}" /scriptfile="updatescript.sql" /report:"predeploy.html"