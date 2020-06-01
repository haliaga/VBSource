Attribute VB_Name = "ReportManager"
Option Explicit

'Exucutes the report according to the command line arguments
Public Sub executeCommandLineReport(cmdLine As String)
        Dim strReportName As String
        Dim styleSheetIndex As Long
        Dim ouputFile As String
        Dim commaPos As Long
        Dim commaPos2 As Long
        Dim cmdLen As Long
        Dim strParameters As String
        
        cmdLen = Len(cmdLine)
        
        commaPos = InStr(1, cmdLine, ",")
        strReportName = Mid(cmdLine, 1, commaPos - 1)
        
        commaPos2 = InStr(commaPos + 1, cmdLine, ",")
        styleSheetIndex = CInt(Mid(cmdLine, commaPos + 1, commaPos2 - commaPos - 1))
        
        commaPos = InStr(commaPos2 + 1, cmdLine, ",")
        If commaPos > 0 Then
            ouputFile = Mid(cmdLine, commaPos2 + 1, commaPos - commaPos2 - 1)
        Else
            ouputFile = Right(cmdLine, cmdLen - commaPos2)
        End If
        
        If commaPos > 0 Then
            strParameters = Right(cmdLine, cmdLen - commaPos)
        End If
        
        Dim repDef As New ReportDefinition
        
        repDef.load getReportPath() + "\" + strReportName
        
        compleateParameters repDef.parameterList, strParameters
        
        If ouputFile = "" Then
             ouputFile = getTempPath() + "\temp.html"
             createReport repDef, ouputFile, styleSheetIndex
             
        
            Dim iexpore As New InternetExplorer

            iexpore.Navigate ouputFile
    
            iexpore.Visible = True
        Else
            createReport repDef, ouputFile, styleSheetIndex
        End If
                

End Sub

Public Function getTempPath() As String
    
    getTempPath = Environ("temp")
End Function


Public Function getReportPath() As String
    getReportPath = App.path + "\reports"
End Function


Public Function getFileList() As Collection
    Dim strFile As String
    Dim clFiles As New Collection
    
    strFile = Dir(getReportPath() + "\*.xml")
    While strFile <> ""
        clFiles.Add strFile
        strFile = Dir()
    Wend
    Set getFileList = clFiles
End Function


'Returns the ADO Conection String
Public Function getConfigConnectionString()
        Dim pathName As String
        Dim fileName As String
        
        fileName = Dir(storageLocation)
        
        pathName = Mid(storageLocation, 1, Len(storageLocation) - Len(fileName))

        Debug.Print pathName
        'HAA__ getConfigConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & storageLocation & ";Persist Security Info=False; Jet OLEDB:Database Password=" & dbPassword
        'HAA__
        getConfigConnectionString = "Driver={SQL Server Native Client 10.0};Server=XP_SQLSERVER_20\SQLEXPRESS;Database=database;Trusted_Connection=yes;"
        
        'getConfigConnectionString = "Provider=MSDASQL.1;Persist Security Info=False;Extended Properties=""DSN=MS Access Database;DBQ=" & fileName & ";DefaultDir=" & pathName & ";DriverId=25;FIL=MS Access;MaxBufferSize=2048;PageTimeout=5;UID=admin;"""
End Function
    
    
Private Function createDocument() As DOMDocument
    Dim xmldoc As New DOMDocument
    
    Dim Pri, Pri2 As Object
    
    'Set Pri = xmldoc.createProcessingInstruction("xml", " version='1.0' encoding='ISO-8859-1'")
    'xmldoc.appendChild (Pri)
        
    Set createDocument = xmldoc
End Function

Private Function genenerateStringValue(varValue As Variant) As String
    Dim Value As String
    
    
    If IsNull(varValue) Then
          Value = ""
    Else
     Value = varValue
'        If IsDate(varValue) Then
'            Value = Format(varValue, "YYYY-MM-DD HH:mm:ss")
'        Else
'            If IsNumeric(varValue) Then
'                Value = varValue
'            Else
'                Value = varValue
'            End If
'        End If
    End If
    
    
    
    genenerateStringValue = Value
    
End Function
    
'Store the table with results
Private Sub createResults(xmldoc As DOMDocument, result As Variant)
    Dim e0 As IXMLDOMElement
    Dim e3_n As IXMLDOMElement
    Dim e3_n_7 As IXMLDOMElement
    
    Set e0 = xmldoc.createElement("report")
    Set e0 = xmldoc.appendChild(e0)

    Dim recCount As Long
    Dim fieldCount As Long
    Dim posrec As Long
    Dim posField As Long
    Dim tagRecord As Variant
    Dim varValue As Variant
    Dim Value As String
    
    If IsEmpty(result) Then
        Exit Sub
    End If
    
    
    recCount = UBound(result, 2)
    fieldCount = UBound(result, 1)
    

    For posrec = 0 To recCount
        Set e3_n = xmldoc.createElement("record")
        Set e3_n = e0.appendChild(e3_n)
        
        For posField = 0 To fieldCount

            varValue = result(posField, posrec)

            
            Set e3_n_7 = xmldoc.createElement("field" + Trim(CStr(posField)))
            Set e3_n_7 = e3_n.appendChild(e3_n_7)
            
            e3_n_7.Text = genenerateStringValue(varValue)
          
            
        Next posField
    Next posrec
    

    
End Sub
    
'Store the parameters information
Private Sub createParameters(xmldoc As DOMDocument, repDef As ReportDefinition)
    Dim e0 As IXMLDOMElement
    Dim e3_n As IXMLDOMElement
    Dim posrec As Long
    
    Set e0 = xmldoc.createElement("parameter_values")
    Set e0 = xmldoc.getElementsByTagName("report").Item(0).appendChild(e0)


    

    For posrec = 0 To repDef.parameterList.Count - 1
        Dim param As parameter
        Set param = repDef.parameterList.Item(posrec + 1)
        Set e3_n = xmldoc.createElement(param.name)
        Set e3_n = e0.appendChild(e3_n)
        e3_n.Text = param.getValue()
            
    Next posrec
    

    
End Sub
    
'Store the parameters information
Private Sub createReportInfo(xmldoc As DOMDocument)
    Dim e0 As IXMLDOMElement
    Dim e3_n As IXMLDOMElement
    Dim posrec As Long
    
    Set e0 = xmldoc.createElement("report_info")
    Set e0 = xmldoc.getElementsByTagName("report").Item(0).appendChild(e0)

    Set e3_n = xmldoc.createElement("time_stamp")
    Set e3_n = e0.appendChild(e3_n)
    e3_n.Text = Format(Now, "YYYY-MM-dd HH:mm:ss")
    
End Sub

    
    
Public Function ExecuteReport(xmlDefinitionPath As String, outputPath As String, styleSheetIndex As Long) As Boolean
    Dim repDef As New ReportDefinition
    ExecuteReport = True
    repDef.load xmlDefinitionPath
    
    If ParameterManager.requestParameters(repDef.parameterList) = False Then
        ExecuteReport = False
        Exit Function
    Else
        createReport repDef, outputPath, styleSheetIndex
    End If
End Function
   
   
    
    
'Executes an SQL query and creates the xml document
Private Sub createReport(repDef As ReportDefinition, outputPath As String, styleSheetIndex As Long)
    Dim cn As New ADODB.Connection
    Dim result As Variant
    Dim xmldoc As DOMDocument
    Dim recs As New ADODB.Recordset
    Dim strSql As String
    
    
    On Error GoTo swerror

    Set xmldoc = createDocument()

    cn.ConnectionString = getConfigConnectionString
    cn.Open
    
    strSql = repDef.buildSQL()
    
    If UCase(Left(strSql, 6)) = "UPDATE" Or UCase(Left(strSql, 6)) = "DELETE" Then
        cn.Execute strSql
    Else
      recs.Open strSql, cn, adOpenKeyset
      If Not recs.EOF Then
        result = recs.GetRows(99999, adBookmarkFirst)
        End If
    End If
    

    createResults xmldoc, result
    createParameters xmldoc, repDef
    createReportInfo xmldoc
    
    cn.Close
    
    Dim texts As String
    Dim xmlSH As New DOMDocument
    
    'If it is definied a stylesheet it save the file in the selected format, otherwise it saves the file as xml
    If styleSheetIndex >= 0 Then
        Dim styleSheetPath As String
    
    
        styleSheetPath = getReportPath + repDef.stylesheetList.Item(styleSheetIndex + 1)
    
    
        xmlSH.load styleSheetPath
    
        texts = xmldoc.transformNode(xmlSH)
        Dim fl As New Stream
   
        fl.Open
        fl.WriteText texts
   
        If Dir(outputPath) <> "" Then
            Kill outputPath
        End If
        fl.SaveToFile outputPath
    Else
        xmldoc.save (outputPath)
    End If
    Exit Sub
    Resume
swerror:
   err.Raise err.Number, err.Source, err.description & vbCr & vbLf & "Query sql=" & strSql, err.HelpFile, err.HelpContext
End Sub
    
    
    
'Executes an SQL query and returns the result
Public Function getDynamicParameter(parameter As String) As String
    Dim cn As New ADODB.Connection
    Dim result As Variant
    Dim xmldoc As DOMDocument
    Dim recs As New ADODB.Recordset
    Dim strSql As String
    
    
    On Error GoTo swerror

    cn.ConnectionString = getConfigConnectionString
    cn.Open
    
    strSql = parameter
    
    If UCase(Left(strSql, 6)) <> "SELECT" Then
        getDynamicParameter = strSql
    Else
      recs.Open strSql, cn, adOpenKeyset
      If Not recs.EOF Then
         result = recs.GetRows(99999, adBookmarkFirst)
         getDynamicParameter = result(0, 0)
        End If
    End If
    

       
    cn.Close
    Exit Function
swerror:
   err.Raise err.Number, err.Source, err.description & vbCr & vbLf & "Query sql=" & strSql, err.HelpFile, err.HelpContext
End Function
