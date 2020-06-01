VERSION 5.00
Begin VB.Form FormPassword 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Please enter database password"
   ClientHeight    =   672
   ClientLeft      =   36
   ClientTop       =   264
   ClientWidth     =   5256
   Icon            =   "FormPassword.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   672
   ScaleWidth      =   5256
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton CommandOk 
      Caption         =   "OK"
      Height          =   372
      Left            =   4320
      TabIndex        =   2
      Top             =   240
      Width           =   732
   End
   Begin VB.TextBox TextPassword 
      Height          =   288
      IMEMode         =   3  'DISABLE
      Left            =   1080
      PasswordChar    =   "*"
      TabIndex        =   1
      Top             =   240
      Width           =   3132
   End
   Begin VB.Label Label1 
      Caption         =   "Password:"
      Height          =   372
      Left            =   120
      TabIndex        =   0
      Top             =   240
      Width           =   852
   End
End
Attribute VB_Name = "FormPassword"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub CommandOk_Click()
    dbPassword = Me.TextPassword
    Me.Hide
    
End Sub

Private Sub Form_Load()
    Me.Hide
End Sub
