 #http://www.red-gate.com/products/oracle-development/dlm-automation-suite-for-oracle/walkthrough

param(
    [Parameter(Mandatory=$true)]
    [string]$password)

$ErrorActionPreference = "Stop"
$here = Split-Path $MyInvocation.MyCommand.Definition

$ScoExe = ".\tools\SCO\SCO.exe"

& $ScoExe /source ".\dbscripts{HR}" /target "System/$password@dev-ora-db.hyperv.lc.skejby/XE{HR}" /scriptfile="updatescript.sql" /report:"predeploy.html"