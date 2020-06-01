VERSION 5.00
Begin VB.MDIForm MDIFormMain 
   BackColor       =   &H8000000C&
   Caption         =   "Brofind Dataloger V1.0"
   ClientHeight    =   4140
   ClientLeft      =   165
   ClientTop       =   735
   ClientWidth     =   6480
   LinkTopic       =   "MDIForm1"
   StartUpPosition =   3  'Windows Default
   Begin VB.Menu Datalog 
      Caption         =   "Datalog"
      Begin VB.Menu StartSampling 
         Caption         =   "Start Sampling"
      End
      Begin VB.Menu StartAtStartup 
         Caption         =   "Start sampling when loading application"
      End
   End
   Begin VB.Menu Variables 
      Caption         =   "Variables"
      Begin VB.Menu ConfigVariables 
         Caption         =   "Config Variables"
      End
   End
   Begin VB.Menu Driver 
      Caption         =   "Driver"
      Begin VB.Menu ConfigDriver 
         Caption         =   "Config"
      End
   End
End
Attribute VB_Name = "MDIFormMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Private Sub ConfigDriver_Click()
    Dim netlink As New NetLinkDriver
    
    netlink.config
End Sub


Private Sub ConfigVariables_Click()
    FormConfigTAGs.Show
End Sub


Private Sub MDIForm_Load()
    setAsSampling False
    
        Dim varStartAtStartup As String
    

    varStartAtStartup = "1234567890"

    GetPrivateProfileString "dataloger", "StartAtStartup", StartAtStartup.Checked, varStartAtStartup, 10, "dalatoger.ini"

    StartAtStartup.Checked = varStartAtStartup
    
    If StartAtStartup.Checked Then
        FormDataLog.Show 1
    End If
End Sub


Private Sub StartAtStartup_Click()
    StartAtStartup.Checked = Not StartAtStartup.Checked
    WritePrivateProfileString "dataloger", "StartAtStartup", CStr(StartAtStartup.Checked), "dalatoger.ini"
End Sub


Private Sub StartSampling_Click()
    setAsSampling True
    FormDataLog.Show 1
    setAsSampling False
End Sub


Private Sub setAsSampling(isSampling As Boolean)
    If isSampling Then
        FormConfigTAGs.Hide
        FormConfigNetLink.Hide
    End If
    Variables.Enabled = Not isSampling
    Driver.Enabled = Not isSampling
    StartSampling.Enabled = Not isSampling
End Sub


