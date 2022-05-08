SET ThisScriptsDirectory=%~dp0
SET PowerShellScriptPath=%ThisScriptsDirectory%audit.ps1
powershell.exe -noprofile -executionpolicy Bypass -file "%PowerShellScriptPath%" -Verb RunAs