VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Parameter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'Parameters Information  of a xml report

Option Explicit

Public name As String 'Name of the parameter embeded in the SQL statement
Public description As String 'Decription of the parameter
Public defaultValue As String 'Defined default value
Public selectedValue As String 'Value selected by the user


Public Function create(aName As String, aDescription As String, aDefaultValue As String) As Parameter
    Dim par As New Parameter
    par.name = aName
    par.description = aDescription
    par.defaultValue = aDefaultValue
    
    selectedValue = Empty
    
    Set create = par
End Function


Public Function getValue() As String
    Dim strValue As String
    If IsEmpty(Me.selectedValue) Or Me.selectedValue = "" Then
        strValue = Me.defaultValue
    Else
        strValue = Me.selectedValue
    End If
    getValue = strValue
End Function

