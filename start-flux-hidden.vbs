Option Explicit

Dim sh, fso, env
Dim projectRoot, appExe, killCmd
Dim missing

Set sh = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
Set env = sh.Environment("PROCESS")

projectRoot = "C:\Users\abhis\Projects\Flux"
appExe = projectRoot & "\src-tauri\target\debug\flux.exe"

' Ensure current process can resolve cargo-based tools if needed by app plugins.
env("Path") = sh.ExpandEnvironmentStrings("%USERPROFILE%") & "\.cargo\bin;" & env("Path")

' Required runtime env values should come from USER environment variables.
missing = ""
If Len(Trim(env("OPENAI_API_KEY"))) = 0 Then missing = missing & "- OPENAI_API_KEY" & vbCrLf
If Len(Trim(env("RESEND_API_KEY"))) = 0 Then missing = missing & "- RESEND_API_KEY" & vbCrLf
If Len(Trim(env("FLUX_EMAIL_TO"))) = 0 Then missing = missing & "- FLUX_EMAIL_TO" & vbCrLf
If Len(Trim(env("FLUX_EMAIL_FROM"))) = 0 Then missing = missing & "- FLUX_EMAIL_FROM" & vbCrLf

' Reasonable default if user did not set it globally.
If Len(Trim(env("FLUX_EMAIL_ENABLED"))) = 0 Then env("FLUX_EMAIL_ENABLED") = "true"

If missing <> "" Then
  MsgBox "Flux cannot start. Missing user environment variables:" & vbCrLf & vbCrLf & missing & vbCrLf & _
         "Set them once (System Properties > Environment Variables), then retry.", vbCritical, "Flux Start Error"
  WScript.Quit 1
End If

' Stop old Flux instances.
killCmd = "cmd /c taskkill /F /IM flux.exe >nul 2>nul"
sh.Run killCmd, 0, True

' Launch Flux hidden (no terminal window).
If fso.FileExists(appExe) Then
  sh.Run """" & appExe & """", 0, False
Else
  MsgBox "Flux executable not found at:" & vbCrLf & appExe & vbCrLf & vbCrLf & _
         "Build once with: npm run tauri:build (or cargo build)", vbCritical, "Flux Start Error"
End If