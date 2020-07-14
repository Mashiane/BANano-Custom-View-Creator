B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.5
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Dim body As BANanoElement
	Private BANano As BANano
End Sub


Sub Init
	BANano.LoadLayout("#body", "alerts")
End Sub