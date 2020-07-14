B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.45
@EndOfDesignText@
'Static code module
#IgnoreWarnings:12
Sub Process_Globals
	Public Name As String = "ComponentsCode"
	Public Title As String = "Components"
	Private vm As BANanoVM
	Private BANano As BANano  'ignore
	Private dlgComponents As VMDialog
	Private dtcomponents As VMDataTable
	Private cont As VMContainer
	Private Mode As String
	Private vue As BANanoVue
	Private sprojectid As String
	Private sprojectname As String
End Sub

Sub Code
	'Establish a reference to the app
	vm = pgIndex.vm
	vue = vm.vue
	vm.setdata("projectname", "")
	'create a container to hold all contents based on the page name
	cont = vm.CreateContainer(Name, Me)
	'hide the container
	cont.Hide
	Dim lbl As VMLabel
	lbl.Initialize(vue, "lblProjectName").SetH2.SetText($"Project Name: {{ projectname }}"$)
	cont.AddControl(lbl.label, lbl.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)
	'
	'add the table to container
	CreateDataTable_components
	'add the dialog to page
	CreateDialog_Components
	'add the container to the page
	vm.AddContainer(cont)
	'add method to get all records
	vm.SetMethod(Me, "SelectAll_Components")
End Sub

'show the page
Sub Show
	'the navbar is visible for this page
	vm.setdata("projectname", "")
	'
	vm.NavBar.Show
	'show the hamburger for this page
	vm.NavBar.Hamburger.SetVisible(True)
	'the drawer should be hidden for this page
	vm.Drawer.Hide
	'the logo should be visible for this page
	vm.NavBar.Logo.Show
	vm.HideItem("navComponents")
	vm.ShowItem("navProjects")
	'2. Show the page and hide others
	vm.ShowPage(Name)
	'read the project details
	Dim project As Map = vm.GetData("project")
	sprojectid = project.get("projectid")
	sprojectname = project.get("projectname")
	'
	vm.setdata("projectname", sprojectname)
	vm.setdata("projectid", sprojectid)
	
	'load records to table
	vm.CallMethod("SelectAll_Components")
End Sub

'delete all records
Sub DeleteAll_Components
	Dim rsComponents As BANanoMySQLE
	rsComponents.Initialize("bananocvc", "components", "componentid", "componentid")
	rsComponents.DeleteAll
	rsComponents.JSON = BANano.CallInlinePHPWait(rsComponents.MethodName, rsComponents.Build)
	rsComponents.FromJSON
	'execute code to refresh listing for Components
	vm.CallMethod("SelectAll_Components")
End Sub

'delete single record
Sub DeleteRecord_Components(RecordID As String)
	Dim rsComponents As BANanoMySQLE
	'initialize table for deletion
	rsComponents.Initialize("bananocvc", "components", "componentid", "componentid")
	'define schema for record
	rsComponents.SchemaFromDesign(dlgComponents.Container)
	'generate & run command to delete single record
	rsComponents.Delete(RecordID)
	rsComponents.JSON = BANano.CallInlinePHPWait(rsComponents.MethodName, rsComponents.Build)
	rsComponents.FromJSON
	'delete attributes
	Dim rsAttributes As BANanoMySQLE
	rsAttributes.Initialize("bananocvc", "attributes", "componentid", "componentid")
	rsAttributes.SchemaAddInt(Array("componentid"))
	rsAttributes.Delete(RecordID)
	rsAttributes.JSON = BANano.CallInlinePHPWait(rsAttributes.MethodName, rsAttributes.Build)
	rsAttributes.FromJSON
	'delete styles
	Dim rsStyles As BANanoMySQLE
	rsStyles.Initialize("bananocvc", "styles", "componentid", "componentid")
	rsStyles.SchemaAddInt(Array("componentid"))
	rsStyles.Delete(RecordID)
	rsStyles.JSON = BANano.CallInlinePHPWait(rsStyles.MethodName, rsStyles.Build)
	rsStyles.FromJSON
	'delete classes
	Dim rsClasses As BANanoMySQLE
	rsClasses.Initialize("bananocvc", "classes", "componentid", "componentid")
	rsClasses.SchemaAddInt(Array("componentid"))
	rsClasses.Delete(RecordID)
	rsClasses.JSON = BANano.CallInlinePHPWait(rsClasses.MethodName, rsClasses.Build)
	rsClasses.FromJSON
	
	'execute code to refresh listing for Components
	vm.CallMethod("SelectAll_Components")
End Sub

'add global attributes, these exist for any element
Sub AddGlobalAttributes(compID As String)
	Dim ga As List = vm.newlist
	ga.AddAll(Array("accesskey","contenteditable","dir","draggable","hidden","lang","spellcheck","tabindex","title","translate"))
	
End Sub

'select all records
Sub SelectAll_Components
	Dim rsComponents As BANanoMySQLE
	'initialize table for table creation
	rsComponents.Initialize("bananocvc", "components", "componentid", "componentid")
	Dim cw As Map = CreateMap()
	cw.put("projectid", sprojectid)
	rsComponents.SelectWhere("components", Array("*"), cw, Array("="), Array("componenttag"))
	rsComponents.JSON = BANano.CallInlinePHPWait(rsComponents.MethodName, rsComponents.Build)
	rsComponents.FromJSON
	'save records to state
	vm.SetData("components", rsComponents.Result)
	'update the data table records
	dtcomponents.SetDataSource(rsComponents.Result)
End Sub

'components Edit action
Sub dtcomponents_edit(item As Map)
	'get the key
	Dim RecID As String = item.Get("componentid")
	If RecID = "" Then Return
	'set mode to E-dit
	Mode = "E"
	'read record from database
	Dim rsComponents As BANanoMySQLE
	'initialize table for table creation
	rsComponents.Initialize("bananocvc", "components", "componentid", "componentid")
	'define schema for record
	rsComponents.SchemaFromDesign(dlgComponents.Container)
	'generate & run command to read record
	rsComponents.Read(RecID)
	rsComponents.JSON = BANano.CallInlinePHPWait(rsComponents.MethodName, rsComponents.Build)
	rsComponents.FromJSON
	'was the read successful?
	If rsComponents.Result.Size = 0 Then Return
	'the record as found!
	Dim Record As Map = rsComponents.result.get(0)
	'Update the dialog details
	dlgComponents.SetTitle("Edit Component")
	'show the modal
	dlgComponents.Show
	'update the state, this updates the v-model(s) for each input control
	vm.SetState(Record)
End Sub

'projects menu action
Sub dtcomponents_menu(item As Map)
	vm.SetData("component", item)
	pgComponent.Show
End Sub

'components Delete action
Sub dtcomponents_delete(item As Map)
	'get the key
	Dim RecID As String = item.Get("componentid")
	If RecID = "" Then Return
	'save the id to delete
	vm.SetData("componentscomponentid", RecID)
	'show confirm dialog
	Dim scomponentdescription As String = item.getdefault("componentdescription","")
	vm.ShowConfirm("delete_components", "Confirm Delete: " & scomponentdescription, _
"Are you sure that you want to delete this Component. You will not be able to undo your actions. Continue?","Ok","Cancel")
End Sub


'add a new Component
Sub AddComponents
	'set mode to A-add
	Mode = "A"
	'update the title
	dlgComponents.SetTitle("New Component")
	'show dialog
	dlgComponents.Show
	vm.Setdata("projectid", sprojectid)
	vm.SetFocus("txtcomponenttag")
End Sub


'when add new is clicked
Sub btnNewComponent_click(e As BANanoEvent)
	AddComponents
End Sub

'create dialog
Sub CreateDialog_Components
	dlgComponents = vm.CreateDialog("dlgComponents", Me)
	dlgComponents.SetTitle("Components")
	dlgComponents.SetOk("btnOkComponents","Save")
	dlgComponents.SetCancel("btnCancelComponents","Cancel")
	dlgComponents.Setwidth("700px")
	dlgComponents.Setpersistent(True)
	'*** Add code to create components below this line!
	Dim txtcomponentid As VMTextField = vm.NewTextField(Me, False, "txtcomponentid", "componentid", "Componentid", "", False, "", 11, "", "", 0)
	txtcomponentid.SetFieldType("int")
	txtcomponentid.SetVisible(False)
	dlgComponents.Container.AddControl(txtcomponentid.textfield, txtcomponentid.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgComponents.Container" is being built!

	Dim txtprojectid As VMTextField = vm.NewTextField(Me, False, "txtprojectid", "projectid", "ProjectID", "", False, "", 11, "", "", 0)
	txtprojectid.SetFieldType("int")
	txtprojectid.SetVisible(False)
	dlgComponents.Container.AddControl(txtprojectid.textfield, txtprojectid.tostring, 2, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgComponents.Container" is being built!


	Dim txtcomponenttag As VMTextField = vm.NewTextField(Me, False, "txtcomponenttag", "componenttag", "HTML Tag", "", True, "", 50, "", "The html tag is required!", 0)
	txtcomponenttag.SetFieldType("string")
	txtcomponenttag.SetHideDetails(True)
	txtcomponenttag.SetVisible(True)
	dlgComponents.Container.AddControl(txtcomponenttag.textfield, txtcomponenttag.tostring, 3, 2, 0, 0, 0, 0, 12, 3, 3, 3)


	'INSTRUCTION: Copy & paste the code below to where your "dlgComponents.Container" is being built!

	Dim txtcomponentdescription As VMTextField = vm.NewTextField(Me, False, "txtcomponentdescription", "componentdescription", "Name", "", False, "", 200, "", "", 0)
	txtcomponentdescription.SetFieldType("string")
	txtcomponentdescription.SetHideDetails(True)
	txtcomponentdescription.SetVisible(True)
	dlgComponents.Container.AddControl(txtcomponentdescription.textfield, txtcomponentdescription.tostring, 3, 1, 0, 0, 0, 0, 12, 9, 9, 9)


	vm.AddDialog(dlgComponents)
End Sub

'add code to save the Component
Sub btnOkComponents_click(e As BANanoEvent)
	'create/update record to table
	'get the record to create/update
	Dim Record As Map = dlgComponents.Container.GetData
	'validate the record
	Dim bValid As Boolean = vm.Validate(Record, dlgComponents.Container.Required)
	'if invalid exit create/update
	If bValid = False Then
		Dim strError As String = vue.GetError
		vm.ShowSnackBarError(strError)
		Return
	End If
	'resultset variable
	Dim rsComponents As BANanoMySQLE
	'check mode
	Select Case Mode
		Case "A"
			'initialize table for insert
			rsComponents.Initialize("bananocvc", "components", "componentid", "componentid")
			'define schema for record
			rsComponents.SchemaFromDesign(dlgComponents.Container)
			'insert a record
			rsComponents.Insert1(Record)
			'generate & run command to insert record
			rsComponents.JSON = BANano.CallInlinePHPWait(rsComponents.MethodName, rsComponents.Build)
			rsComponents.FromJSON
		Case "E"
			'read record id
			Dim RecID As String = Record.Get("componentid")
			'initialize table for edit
			rsComponents.Initialize("bananocvc", "components", "componentid", "componentid")
			'define schema for record
			rsComponents.SchemaFromDesign(dlgComponents.Container)
			'update a record
			rsComponents.Update1(Record, RecID)
			'generate & run command to update record
			rsComponents.JSON = BANano.CallInlinePHPWait(rsComponents.MethodName, rsComponents.Build)
			rsComponents.FromJSON
	End Select
	'hide the modal
	dlgComponents.Hide
	'execute code to refresh listing for Components
	vm.CallMethod("SelectAll_Components")
End Sub

'add code to cancel the dialog for Component
Sub btnCancelComponents_click(e As BANanoEvent)
	'hide the modal
	dlgComponents.Hide
End Sub

Sub CreateDataTable_components
	dtcomponents = vm.CreateDataTable("dtcomponents", "componentid", Me)
	dtcomponents.SetTitle("Components")
	dtcomponents.SetSearchbox(True)
	dtcomponents.SetAddNew("btnNewComponent", "mdi-plus", "Add a new component")
	dtcomponents.SetItemsperpage("1000")
	dtcomponents.SetMobilebreakpoint("600")
	dtcomponents.SetMultisort(True)
	dtcomponents.SetPage("1")
	dtcomponents.SetSingleselect(True)
	dtcomponents.SetVisible(True)
	dtcomponents.AddColumn1("componentdescription", "Name", "text",0,False,"start")
	dtcomponents.AddColumn1("componenttag", "HTML Tag", "text",0,True,"start")
	dtcomponents.SetEdit(True)
	dtcomponents.SetDelete(True)
	dtcomponents.SetMenu(True)
	dtcomponents.SetIconDimensions1("edit", "24px", "success","80")
	dtcomponents.SetIconDimensions1("delete", "24px", "error","80")
	dtcomponents.SetIconDimensions1("menu", "24px", "orange","80")
	cont.AddControl(dtcomponents.DataTable, dtcomponents.tostring, 2, 1, 0, 0, 0, 0, 12, 12, 12, 12)
End Sub