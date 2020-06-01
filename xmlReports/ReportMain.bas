Attribute VB_Name = "ReportMain"
Public storageLocation As String   ' It Store the location of file
Public dbPassword      As String   ' It Store the database password
Public requestPassword As Integer  'It stablish if the password is requested
Public Const appName   As String = "Software\Brofind\Brofind XML Reports" 'register entry


Public Sub main()
    Dim cmdLine As String
    Dim cmdLen As Long
    
    ReadConfig

    cmdLine = Command()
    
    
    
    If cmdLine = "" Then
        If requestPassword Then
            FormPassword.Show 1
            Unload FormPassword
        End If
        FormReportList.Show
    Else
        ReportManager.executeCommandLineReport cmdLine
    End If

   

  
End Sub

Public Sub ReadConfig()
        Call fReadValue("HKLM", appName, "StorageLocation" _
    , "S", "", storageLocation)
    
        Call fReadValue("HKLM", appName, "dbPassword" _
    , "S", "", dbPassword)
    
       Call fReadValue("HKLM", appName, "requestPassword" _
    , "D", 0, requestPassword)
    
End Sub
