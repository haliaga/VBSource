VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form frmLogsTo 
   AutoRedraw      =   -1  'True
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Configuration"
   ClientHeight    =   2088
   ClientLeft      =   48
   ClientTop       =   288
   ClientWidth     =   7464
   Icon            =   "frmLogsTo.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   ScaleHeight     =   2088
   ScaleWidth      =   7464
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.Frame Frame1 
      Height          =   1932
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7332
      Begin VB.CheckBox CheckRequestPassword 
         Caption         =   "Request password when the application starts"
         Height          =   252
         Left            =   120
         TabIndex        =   6
         Top             =   1440
         Width           =   5172
      End
      Begin VB.TextBox TextPassword 
         Height          =   288
         IMEMode         =   3  'DISABLE
         Left            =   960
         PasswordChar    =   "*"
         TabIndex        =   5
         Top             =   960
         Width           =   4332
      End
      Begin VB.CommandButton cmdSearch 
         Caption         =   "&Search"
         Height          =   375
         Left            =   5400
         TabIndex        =   2
         Top             =   480
         Width           =   1815
      End
      Begin VB.TextBox txtFile 
         Height          =   285
         Left            =   120
         TabIndex        =   1
         Top             =   480
         Width           =   5172
      End
      Begin MSComDlg.CommonDialog CommonDialog1 
         Left            =   2880
         Top             =   120
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin VB.Label Label1 
         Caption         =   "Password:"
         Height          =   252
         Left            =   120
         TabIndex        =   4
         Top             =   960
         Width           =   852
      End
      Begin VB.Label Label4 
         Caption         =   "Select file:"
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   240
         Width           =   855
      End
   End
End
Attribute VB_Name = "frmLogsTo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim whereIsTheError As String


Private Sub Form_Load()
    On Error GoTo err
    
    Dim hMenu           As Long

    whereIsTheError = "Error in the procedure Form_Load of frmLogsTo"
    Dim intChk As Integer
    
    
    
    ' Put the path in the text area
    Me.txtFile = storageLocation
    Me.TextPassword.Text = dbPassword
    Me.CheckRequestPassword.Value = requestPassword

    
    Exit Sub
    
err:
    MsgBox err.description & vbCrLf & vbCrLf & whereIsTheError, vbCritical

End Sub

Private Sub cmdSearch_Click()
    On Error GoTo err
    
    Dim o As New ADODB.Connection
    Dim strConection As String
    Dim lResult         As Long
    
    CommonDialog1.CancelError = True
    CommonDialog1.Filter = "*.mdb|*.mdb"
    CommonDialog1.ShowOpen
    
    'strConection = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="
    'strConection = strConection & CommonDialog1.fileName
    'strConection = strConection & ";Persist Security Info=False"
    
     Me.txtFile = CommonDialog1.fileName
    
    ' To write into the registry
    storageLocation = Me.txtFile
    Call fWriteValue("HKLM", appName, "StorageLocation", "S", storageLocation)
    
    o.ConnectionString = getConfigConnectionString
    o.Open
   
    Exit Sub
    Resume Next
err:
    If err.Number <> 32755 Then
        MsgBox err.description & vbCrLf & vbCrLf & whereIsTheError, vbCritical
    End If

End Sub

Private Sub Form_Unload(Cancel As Integer)
    dbPassword = Me.TextPassword.Text
    requestPassword = Me.CheckRequestPassword.Value
    
    Call fWriteValue("HKLM", appName, "dbPassword", "S", dbPassword)
    Call fWriteValue("HKLM", appName, "requestPassword", "D", requestPassword)
    
    
End Sub

Private Sub TextPassword_Change()
    dbPassword = Me.TextPassword.Text
End Sub
