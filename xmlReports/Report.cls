VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ReportDefinition"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public name As String
Public description As String
Public sqlCommand As String

Public stylesheetList As Collection 'Collection of stylesheets
Public parameterList As Collection 'Collection of parameters

'Retuns a Collection with the parameters of the Report
Private Sub buildParameterList(xmldoc As DOMDocument)
    Dim pos As Long
    
    Dim pname As String 'Name of the parameter embeded in the SQL statement
    Dim pdescription As String 'Decription of the parameter
    Dim pdefaultValue As String 'Defined default value
    
    Set parameterList = New Collection
    
    
    For pos = 0 To xmldoc.getElementsByTagName("report_definition/parameter_list/parameter").length - 1
        pname = xmldoc.getElementsByTagName("report_definition/parameter_list/parameter/name").Item(pos).Text
        pdescription = xmldoc.getElementsByTagName("report_definition/parameter_list/parameter/description").Item(pos).Text
        pdefaultValue = xmldoc.getElementsByTagName("report_definition/parameter_list/parameter/default_value").Item(pos).Text
        
        Dim pr As New Parameter
        
        Set pr = pr.create(pname, pdescription, pdefaultValue)
        
        parameterList.Add pr
    Next pos

End Sub


'Retuns a Collection with the parameters of the Report
Private Sub buildStyleSheetList(xmldoc As DOMDocument)
    Dim pos As Long
    Dim path As String
    
    Set stylesheetList = New Collection
    
    
    For pos = 0 To xmldoc.getElementsByTagName("report_definition/stylesheet_list/stylesheet").length - 1
        path = xmldoc.getElementsByTagName("report_definition/stylesheet_list/stylesheet/path").Item(pos).Text
        stylesheetList.Add path
    Next pos
    
End Sub

'Creates the SQL statement usign the parameters
Public Function buildSQL()
    Dim strSql As String
    Dim pos As Long
    
    strSql = sqlCommand
    
    For pos = 0 To parameterList.Count - 1
        Dim par As Parameter
        
        Set par = parameterList.Item(pos + 1)
        
        strSql = Replace(strSql, "%" + par.name + "%", par.getValue())
    Next pos
    
    buildSQL = strSql
End Function


Public Sub load(xmlDefinitionPath As String)
    Dim xmldoc As New DOMDocument
    Dim strFile As String
    Dim pos As Integer
    Dim strSql As String
    Dim jj As Variant
    
    xmldoc.load xmlDefinitionPath
    name = xmldoc.getElementsByTagName("report_definition/name").Item(0).Text
    description = xmldoc.getElementsByTagName("report_definition/description").Item(0).Text
    sqlCommand = xmldoc.getElementsByTagName("report_definition/sql_command").Item(0).Text
    
    buildStyleSheetList xmldoc
    buildParameterList xmldoc
   
End Sub


