VERSION 5.00
Begin VB.Form FormReportList 
   Caption         =   "Select the report to execute"
   ClientHeight    =   3360
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7815
   Icon            =   "FormReportList.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3360
   ScaleWidth      =   7815
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton CommandConfig 
      Caption         =   "Configuration"
      Height          =   372
      Left            =   6120
      TabIndex        =   4
      Top             =   2880
      Width           =   1572
   End
   Begin VB.CommandButton CommandViewDetials 
      Caption         =   "View Definition"
      Height          =   375
      Left            =   6120
      TabIndex        =   3
      Top             =   600
      Width           =   1575
   End
   Begin VB.CommandButton Execute 
      Caption         =   "View Results"
      Height          =   375
      Left            =   6120
      TabIndex        =   2
      Top             =   120
      Width           =   1575
   End
   Begin VB.CommandButton CommandExportToExcel 
      Caption         =   "Export To Excel"
      Height          =   375
      Left            =   6120
      TabIndex        =   1
      ToolTipText     =   "Exports to Comma Separated Values format"
      Top             =   1080
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.ListBox ListReports 
      Height          =   2790
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5895
   End
End
Attribute VB_Name = "FormReportList"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private Sub ExportToExcell()
    Dim strFile As String

    strFile = getReportPath() + "\data\temp.csv"
    
    ReportManager.ExecuteReport getSelectedFilePath(), strFile, 1

End Sub



Private Sub CommandConfig_Click()
    frmLogsTo.Show
End Sub

Private Sub CommandExportToExcel_Click()
    ExportToExcell
End Sub

Private Sub CommandViewDetials_Click()
    Dim strFile As String
    
    strFile = getSelectedFilePath
    
    Dim iexpore As New InternetExplorer
    
   iexpore.Navigate strFile
   
   iexpore.Visible = True
End Sub


Private Sub ExecuteReport()
On Error GoTo err

    Dim strFile As String

    strFile = getTempPath() + "\temp.html"
    
    Dim rd As New ReportDefinition
    
    rd.load getSelectedFilePath()
    
    If ReportManager.ExecuteReport(getSelectedFilePath(), strFile, 0) = True Then
        Dim iexpore As New InternetExplorer
    
        iexpore.Navigate strFile
   
        iexpore.Visible = True
    End If
    Exit Sub
err:
     MsgBox (err.description)
End Sub

Private Sub Execute_Click()
    ExecuteReport
End Sub



Private Sub Form_Load()

   
    fillList
       
End Sub


Private Function getSelectedFilePath() As String

    Dim itemselected As Integer
 
    itemselected = ListReports.ListIndex
    
    Dim strFile As String
    strFile = getReportPath() + "\" + getFileList.Item(itemselected + 1)
    
    getSelectedFilePath = strFile
End Function



Private Sub fillList()
    Dim clFiles As Collection
    Set clFiles = getFileList
    readNames clFiles
    ListReports.Refresh
    If (clFiles.Count > 0) Then
        ListReports.ListIndex = 0
    End If
End Sub




Private Sub readNames(clFiles As Collection)
    Dim xmldoc As New DOMDocument
    Dim strFile As String
    Dim pos As Integer
    Dim strName As String
    Dim jj As Variant
    
    For pos = 1 To clFiles.Count
        strFile = clFiles.Item(pos)
        xmldoc.load getReportPath() + "\" + strFile
       strName = xmldoc.getElementsByTagName("report_definition/name").Item(0).Text
            ListReports.AddItem strName
    Next pos
    
    
End Sub




Private Sub ListReports_DblClick()
    ExecuteReport
End Sub
