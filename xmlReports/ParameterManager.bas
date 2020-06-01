Attribute VB_Name = "ParameterManager"








'Requests to the user the parameter values
Public Function requestParameters(pars As Collection) As Boolean
    Dim pos As Long
    requestParameters = True
    
    For pos = 0 To pars.Count - 1
        Dim par As parameter
        
        Set par = pars.Item(pos + 1)
        
 'todo parameter dynamic
        par.defaultValue = ReportManager.getDynamicParameter(par.defaultValue)
 
        
        
        FormParameterValueFill.setParameter par
        FormParameterValueFill.Show 1
        If FormParameterValueFill.cancel Then
             requestParameters = False
            Exit Function
        Else
            par.selectedValue = FormParameterValueFill.getValue
        End If
        
    Next pos

End Function


'Get from the command Line the parameter values
Public Function compleateParameters(pars As Collection, cmdLine As String) As Collection
    Dim pos As Long
    Dim commaPos As Long
    Dim commaPos2 As Long
    Dim strParamValue As String
    
    commaPos = 1
    
    If pars.Count = 0 Then Exit Function
    
    Do
        Dim par As parameter
        
       
        
        commaPos2 = InStr(commaPos, cmdLine, ",")
        If commaPos2 <> 0 Then
            strParamValue = Mid(cmdLine, commaPos, commaPos2 - commaPos)
        Else
            strParamValue = Right(cmdLine, Len(cmdLine) - commaPos + 1)
        End If
        Set par = pars.Item(pos + 1)
        If strParamValue <> "" Then
            par.selectedValue = strParamValue
        End If
        
        
        
        pos = pos + 1
        commaPos = commaPos2 + 1
    Loop While (commaPos2 <> 0)


End Function
