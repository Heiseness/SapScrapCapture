If Not IsObject(application) Then
   Set SapGuiAuto  = GetObject("SAPGUI")
   Set application = SapGuiAuto.GetScriptingEngine
End If
If Not IsObject(connection) Then
   Set connection = application.Children(0)
End If
If Not IsObject(session) Then
   Set session    = connection.Children(0)
End If
If IsObject(WScript) Then
   WScript.ConnectObject session,     "on"
   WScript.ConnectObject application, "on"
End If
session.findById("wnd[0]").maximize
session.findById("wnd[0]/tbar[0]/btn[15]").press
session.findById("wnd[0]/tbar[0]/okcd").text = "mb51"
session.findById("wnd[0]").sendVKey 0
session.findById("wnd[0]/usr/ctxtWERKS-LOW").text = "jm03"
session.findById("wnd[0]/usr/ctxtLGORT-LOW").text = "WIP1"
session.findById("wnd[0]/usr/ctxtBWART-LOW").text = "901"
session.findById("wnd[0]/usr/ctxtLIFNR-LOW").text = ""
session.findById("wnd[0]/usr/txtMBLNR-LOW").text = ""
session.findById("wnd[0]/usr/ctxtBUDAT-LOW").setFocus
session.findById("wnd[0]/usr/ctxtBUDAT-LOW").caretPosition = 0
session.findById("wnd[0]").sendVKey 4
session.findById("wnd[1]/tbar[0]/btn[0]").press
session.findById("wnd[0]/tbar[1]/btn[8]").press
session.findById("wnd[0]").sendVKey 48
session.findById("wnd[0]").sendVKey 33
session.findById("wnd[1]/usr/ssubD0500_SUBSCREEN:SAPLSLVC_DIALOG:0501/cntlG51_CONTAINER/shellcont/shell").firstVisibleRow = 279
session.findById("wnd[1]/usr/ssubD0500_SUBSCREEN:SAPLSLVC_DIALOG:0501/cntlG51_CONTAINER/shellcont/shell").setCurrentCell 288,"TEXT"
session.findById("wnd[1]/usr/ssubD0500_SUBSCREEN:SAPLSLVC_DIALOG:0501/cntlG51_CONTAINER/shellcont/shell").selectedRows = "288"
session.findById("wnd[1]/usr/ssubD0500_SUBSCREEN:SAPLSLVC_DIALOG:0501/cntlG51_CONTAINER/shellcont/shell").clickCurrentCell
session.findById("wnd[0]/usr/cntlGRID1/shellcont/shell").setCurrentCell -1,"MBLNR"
session.findById("wnd[0]/usr/cntlGRID1/shellcont/shell").selectColumn "MBLNR"
session.findById("wnd[0]/usr/cntlGRID1/shellcont/shell").contextMenu
session.findById("wnd[0]/usr/cntlGRID1/shellcont/shell").selectContextMenuItem "&XXL"
session.findById("wnd[1]/tbar[0]/btn[0]").press


Set fso = CreateObject("Scripting.FileSystemObject")
scriptPath = fso.GetParentFolderName(WScript.ScriptFullName)
formato = fso.BuildPath(scriptPath, "EXPORT.xlsx")


session.findById("wnd[1]/usr/ctxtDY_PATH").text = scriptPath
session.findById("wnd[1]/usr/ctxtDY_PATH").setFocus
session.findById("wnd[1]/usr/ctxtDY_PATH").caretPosition = 45
session.findById("wnd[1]/tbar[0]/btn[11]").press
