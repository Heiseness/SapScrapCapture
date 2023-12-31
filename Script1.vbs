' Se crea la conexcion con SAP
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

Private  Function ups()
   If Err.Number <> 0 Then
      ' La casilla no existe, maneja el error
	  session.findById("wnd[0]/tbar[0]/btn[3]").press
	  session.findById("wnd[0]/tbar[0]/btn[3]").press
	  session.findById("wnd[0]/tbar[0]/btn[3]").press
  End If
  ' Reinicia el objeto de error
  Err.Clear

End Function

' Iniciamos haciendo un set del archivo de excel por usar
' El archivo de excel se encuentra en el escritorio con el nombre "Scrap-hoy"

Set fso = CreateObject("Scripting.FileSystemObject")
scriptPath = fso.GetParentFolderName(WScript.ScriptFullName)
formato = fso.BuildPath(scriptPath, "Scrap-hoy.xlsx")

Set xlApp = CreateObject("Excel.Application")
Set xlWorkbook = xlApp.Workbooks.Open(formato)
Set xlWorksheet1 = xlWorkbook.Worksheets(2)

total_nums = xlWorksheet1.Range("i3").Value 'cantidad de hojas qeu se van a abrir
total_cells = xlWorksheet1.Range("i1").Value
np_qnt = xlWorksheet1.Range("i2").Value
fecha = xlWorksheet1.Range("i4")
material_doc = xlWorksheet1.Range("E2").Value
movimiento = xlWorksheet1.Range("K1").Value


session.findById("wnd[0]/usr/txtMKPF-BKTXT").text = material_doc
session.findById("wnd[0]/usr/ctxtMKPF-BLDAT").text = fecha
session.findById("wnd[0]/usr/ctxtMKPF-BUDAT").text = fecha
session.findById("wnd[0]/usr/ctxtRM07M-BWARTWA").text = movimiento
session.findById("wnd[0]/usr/ctxtRM07M-WERKS").text = "JM03"
session.findById("wnd[0]/usr/ctxtRM07M-LGORT").text = "WIP1"
session.findById("wnd[0]/usr/ctxtRM07M-GRUND").text = "1"
session.findById("wnd[0]/usr/ctxtRM07M-GRUND").caretPosition = 1

' Se acepta esta webada
session.findById("wnd[0]").sendVKey 0

'Entramos a nuestra nueva pantalla (Donde se registra ahora si los PN)
session.findById("wnd[0]/usr/subBLOCK:SAPLKACB:1001/ctxtCOBL-KOSTL").text = xlWorksheet1.Range("D2").Value

'Iniciamos con el llenado de la columnas

On Error Resume Next


for j = 0 To (total_nums)
	for i = 0 To (total_cells - 1)

 		' Construir el índice del campo de texto en SAP

		valor = (2 + (total_cells*j) + i)

    		indice = "[" & i & ",7]"
    		indice_qt = "[" & i & ",26]"
    		indice_ucm = "[" & i & ",44]"


		material = xlWorksheet1.Range("A" & (valor)).Value 
    		qnty = xlWorksheet1.Range("B" & (valor)).Value
    		ucm = xlWorksheet1.Range("C" & (valor)).Value
	
		If qnty <> 0 then
			' Asignar el valor de la columna A al campo de texto en SAP
			session.findById("wnd[0]/usr/sub:SAPMM07M:0421/ctxtMSEG-MATNR" & indice).text = material
			session.findById("wnd[0]/usr/sub:SAPMM07M:0421/txtMSEG-ERFMG" & indice_qt).text = qnty
			session.findById("wnd[0]/usr/sub:SAPMM07M:0421/ctxtMSEG-ERFME" & indice_ucm).text = ucm
		Else
			
		End If
	Next
	session.findById("wnd[0]").sendVKey 19

	ups 'funcion de error

Next

session.findById("wnd[0]").sendVKey 81
session.findById("wnd[0]/tbar[0]/btn[11]").press

xlWorkbook.Close
xlApp.Quit
Set xlWorksheet1 = Nothing
Set xlWorkbook = Nothing
Set xlApp = Nothing






