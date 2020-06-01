VERSION 5.00
Begin VB.Form FormParameterValueFill 
   Caption         =   "Complete the parameter value"
   ClientHeight    =   1080
   ClientLeft      =   60
   ClientTop       =   348
   ClientWidth     =   7200
   Icon            =   "FormParameterValueFill.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1080
   ScaleWidth      =   7200
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton CommandCancel 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   5640
      TabIndex        =   3
      Top             =   120
      Width           =   1455
   End
   Begin VB.Frame FrameDescrip 
      Caption         =   "Frame1"
      Height          =   855
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   5415
      Begin VB.TextBox TextValue 
         Height          =   375
         Left            =   120
         TabIndex        =   2
         Text            =   "Text1"
         Top             =   240
         Width           =   5175
      End
   End
   Begin VB.CommandButton CommandOk 
      Caption         =   "Ok"
      Height          =   375
      Left            =   5640
      TabIndex        =   0
      Top             =   600
      Width           =   1455
   End
End
Attribute VB_Name = "FormParameterValueFill"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Value As String
Public cancel As Boolean

Public Sub setParameter(descrip As parameter)
    FrameDescrip.Caption = descrip.description
    TextValue.Text = descrip.defaultValue
    cancel = True
End Sub


Public Function getValue() As String
    getValue = Value
End Function




Private Sub CommandCancel_Click()
    Me.Hide
End Sub

Private Sub CommandOk_Click()
    Value = TextValue.Text
    cancel = False
    Me.Hide
End Sub

Private Sub Form_Load()
    cancel = True
End Sub

Private Sub Form_Terminate()
    Value = TextValue.Text
End Sub
