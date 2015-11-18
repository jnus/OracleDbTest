 #http://www.red-gate.com/products/oracle-development/dlm-automation-suite-for-oracle/walkthrough

$password=$OctopusParameters["dbPassword"]
$host = $OctopusParameters["dbServer"]

$ErrorActionPreference = "Stop"
$here = Split-Path $MyInvocation.MyCommand.Definition

$ScoExe = ".\tools\SCO\SCO.exe"

& $ScoExe /source ".\dbscripts{HR}" /target "System/$password@$host/XE{HR}" /scriptfile="updatescript.sql" /report:"predeploy.html"