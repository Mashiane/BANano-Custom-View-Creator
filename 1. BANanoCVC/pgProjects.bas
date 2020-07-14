B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.45
@EndOfDesignText@
'Static code module
#IgnoreWarnings:12
Sub Process_Globals
	Public Name As String = "ProjectsCode"
	Public Title As String = "Projects"
	Private vm As BANanoVM
	Private BANano As BANano  'ignore
	Private dlgProjects As VMDialog
	Private dtprojects As VMDataTable
	Private cont As VMContainer
	Private Mode As String
	Private vue As BANanoVue
	Private php As BANanoPHP
End Sub

Sub Code
	'Establish a reference to the app
	vm = pgIndex.vm
	vue = vm.vue
	'create a container to hold all contents based on the page name
	cont = vm.CreateContainer(Name, Me)
	'hide the container
	cont.Hide
	'add the table to container
	CreateDataTable_projects
	'add the dialog to page
	CreateDialog_Projects
	'add the container to the page
	vm.AddContainer(cont)
	'add method to get all records
	vm.SetMethod(Me, "SelectAll_Projects")
End Sub

'show the page
Sub Show
	'the navbar is visible for this page
	vm.NavBar.Show
	'show the hamburger for this page
	vm.NavBar.Hamburger.SetVisible(True)
	'the drawer should be visible for this page
	vm.Drawer.Hide
	'the logo should be visible for this page
	vm.NavBar.Logo.Show
	'hide Projects on navbar
	vm.HideItem("navProjects")
	vm.HideItem("navComponents")
	'2. Show the page and hide others
	vm.ShowPage(Name)
	'load records to table
	vm.CallMethod("SelectAll_Projects")
End Sub

'delete all records
Sub DeleteAll_Projects
	Dim rsProjects As BANanoMySQLE
	'initialize table for table creation
	rsProjects.Initialize("bananocvc", "projects", "projectid", "projectid")
	rsProjects.DeleteAll
	rsProjects.JSON = BANano.CallInlinePHPWait(rsProjects.MethodName, rsProjects.Build)
	rsProjects.FromJSON
	'execute code to refresh listing for Projects
	vm.CallMethod("SelectAll_Projects")
End Sub

'delete single record
Sub DeleteRecord_Projects(RecordID As String)
	Dim rsProjects As BANanoMySQLE
	'initialize table for deletion
	rsProjects.Initialize("bananocvc", "projects", "projectid", "projectid")
	'define schema for record
	rsProjects.SchemaFromDesign(dlgProjects.Container)
	'generate & run command to delete single record
	rsProjects.Delete(RecordID)
	rsProjects.JSON = BANano.CallInlinePHPWait(rsProjects.MethodName, rsProjects.Build)
	rsProjects.FromJSON
	'
	'delete components
	Dim rsComponents As BANanoMySQLE
	rsComponents.Initialize("bananocvc", "components", "projectid", "projectid")
	rsComponents.SchemaAddInt(Array("projectid"))
	rsComponents.Delete(RecordID)
	rsComponents.JSON = BANano.CallInlinePHPWait(rsComponents.MethodName, rsComponents.Build)
	rsComponents.FromJSON
	'delete attributes
	Dim rsAttributes As BANanoMySQLE
	rsAttributes.Initialize("bananocvc", "attributes", "projectid", "projectid")
	rsAttributes.SchemaAddInt(Array("projectid"))
	rsAttributes.Delete(RecordID)
	rsAttributes.JSON = BANano.CallInlinePHPWait(rsAttributes.MethodName, rsAttributes.Build)
	rsAttributes.FromJSON
	'delete styles
	Dim rsStyles As BANanoMySQLE
	rsStyles.Initialize("bananocvc", "styles", "projectid", "projectid")
	rsStyles.SchemaAddInt(Array("projectid"))
	rsStyles.Delete(RecordID)
	rsStyles.JSON = BANano.CallInlinePHPWait(rsStyles.MethodName, rsStyles.Build)
	rsStyles.FromJSON
	'delete classes
	Dim rsClasses As BANanoMySQLE
	rsClasses.Initialize("bananocvc", "classes", "projectid", "projectid")
	rsClasses.SchemaAddInt(Array("projectid"))
	rsClasses.Delete(RecordID)
	rsClasses.JSON = BANano.CallInlinePHPWait(rsClasses.MethodName, rsClasses.Build)
	rsClasses.FromJSON
	'execute code to refresh listing for Projects
	vm.CallMethod("SelectAll_Projects")
End Sub

'select all records
Sub SelectAll_Projects
	Dim rsProjects As BANanoMySQLE
	'initialize table for table creation
	rsProjects.Initialize("bananocvc", "projects", "projectid", "projectid")
	'generate & run command to select all records
	Dim strSQL As String = "SELECT * from projects order by projectname"
	rsProjects.Execute(strSQL)
	rsProjects.JSON = BANano.CallInlinePHPWait(rsProjects.MethodName, rsProjects.Build)
	rsProjects.FromJSON
	'save records to state
	vm.SetData("projects", rsProjects.Result)
	'update the data table records
	dtprojects.SetDataSource(rsProjects.Result)
End Sub

'projects Edit action
Sub dtprojects_edit(item As Map)
	'get the key
	Dim RecID As String = item.Get("projectid")
	If RecID = "" Then Return
	'set mode to E-dit
	Mode = "E"
	'read record from database
	Dim rsProjects As BANanoMySQLE
	'initialize table for table creation
	rsProjects.Initialize("bananocvc", "projects", "projectid", "projectid")
	'define schema for record
	rsProjects.SchemaFromDesign(dlgProjects.Container)
	'generate & run command to read record
	rsProjects.Read(RecID)
	rsProjects.JSON = BANano.CallInlinePHPWait(rsProjects.MethodName, rsProjects.Build)
	rsProjects.FromJSON
	'was the read successful?
	If rsProjects.Result.Size = 0 Then Return
	'the record as found!
	Dim Record As Map = rsProjects.result.get(0)
	'Update the dialog details
	dlgProjects.SetTitle("Edit Project")
	'show the modal
	dlgProjects.Show
	'update the state, this updates the v-model(s) for each input control
	vm.SetState(Record)
End Sub


'projects Delete action
Sub dtprojects_delete(item As Map)
	'get the key
	Dim RecID As String = item.Get("projectid")
	If RecID = "" Then Return
	'save the id to delete
	vm.SetData("projectsprojectid", RecID)
	'show confirm dialog
	Dim sprojectname As String = item.getdefault("projectname","")
	vm.ShowConfirm("delete_projects", "Confirm Delete: " & sprojectname, _
"Are you sure that you want to delete this Project. You will not be able to undo your actions. Continue?","Ok","Cancel")
End Sub

'projects menu action
Sub dtprojects_menu(item As Map)
	'save the project details
	vm.SetData("project", item)
	'show the components for the project
	pgComponents.Show
End Sub

'add a new Project
Sub AddProjects
	'set mode to A-add
	Mode = "A"
	'update the title
	dlgProjects.SetTitle("New Project")
	'show dialog
	dlgProjects.Show
	vm.SetFocus("txtprojectname")
End Sub


'when add new is clicked
Sub btnNewProject_click(e As BANanoEvent)
	AddProjects
End Sub

'create dialog
Sub CreateDialog_Projects
	dlgProjects = vm.CreateDialog("dlgProjects", Me)
	dlgProjects.SetTitle("Projects")
	dlgProjects.SetOk("btnOkProjects","Save")
	dlgProjects.SetCancel("btnCancelProjects","Cancel")
	dlgProjects.Setwidth("800px")
	dlgProjects.Setpersistent(True)
	'*** Add code to create components below this line!
	'INSTRUCTION: Copy & paste the code below to where your "dlgProjects.Container" is being built!

	Dim txtprojectid As VMTextField = vm.NewTextField(Me, False, "txtprojectid", "projectid", "Projectid", "", False, "", 11, "", "", 0)
	txtprojectid.SetFieldType("int")
	txtprojectid.SetVisible(False)
	dlgProjects.Container.AddControl(txtprojectid.textfield, txtprojectid.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgProjects.Container" is being built!

	Dim txtprojectname As VMTextField = vm.NewTextField(Me, False, "txtprojectname", "projectname", "Project Name", "", True, "", 100, "", "The project name is required!", 0)
	txtprojectname.SetFieldType("string")
	txtprojectname.SetAutoFocus(True)
	txtprojectname.SetHideDetails(True)
	txtprojectname.SetVisible(True)
	dlgProjects.Container.AddControl(txtprojectname.textfield, txtprojectname.tostring, 2, 1, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgProjects.Container" is being built!

	Dim txtprojectauthor As VMTextField = vm.NewTextField(Me, False, "txtprojectauthor", "projectauthor", "Project Author", "", True, "", 100, "", "The project author is required!", 0)
	txtprojectauthor.SetFieldType("string")
	txtprojectauthor.SetHideDetails(True)
	txtprojectauthor.SetVisible(True)
	dlgProjects.Container.AddControl(txtprojectauthor.textfield, txtprojectauthor.tostring, 2, 2, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgProjects.Container" is being built!

	Dim txtprojectversion As VMTextField = vm.NewTextField(Me, False, "txtprojectversion", "projectversion", "Project Version", "", False, "", 10, "", "", 0)
	txtprojectversion.SetFieldType("string")
	txtprojectversion.SetHideDetails(True)
	txtprojectversion.SetVisible(True)
	dlgProjects.Container.AddControl(txtprojectversion.textfield, txtprojectversion.tostring, 3, 1, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgProjects.Container" is being built!

	Dim txtprojectprefix As VMTextField = vm.NewTextField(Me, False, "txtprojectprefix", "projectprefix", "Project Prefix", "", False, "", 10, "", "", 0)
	txtprojectprefix.SetFieldType("string")
	txtprojectprefix.SetHideDetails(True)
	txtprojectprefix.SetVisible(True)
	dlgProjects.Container.AddControl(txtprojectprefix.textfield, txtprojectprefix.tostring, 3, 2, 0, 0, 0, 0, 12, 6, 6, 6)


	vm.AddDialog(dlgProjects)
End Sub

'add code to save the Project
Sub btnOkProjects_click(e As BANanoEvent)
	'create/update record to table
	'get the record to create/update
	Dim Record As Map = dlgProjects.Container.GetData
	'validate the record
	Dim bValid As Boolean = vm.Validate(Record, dlgProjects.Container.Required)
	'if invalid exit create/update
	If bValid = False Then
		Dim strError As String = vue.GetError
		vm.ShowSnackBarError(strError)
		Return
	End If
	'get the project name
	Dim sprojectname As String = Record.get("projectname")
	'resultset variable
	Dim rsProjects As BANanoMySQLE
	'check mode
	Select Case Mode
		Case "A"
			'initialize table for insert
			rsProjects.Initialize("bananocvc", "projects", "projectid", "projectid")
			'define schema for record
			rsProjects.SchemaFromDesign(dlgProjects.Container)
			'insert a record
			rsProjects.Insert1(Record)
			'generate & run command to insert record
			rsProjects.JSON = BANano.CallInlinePHPWait(rsProjects.MethodName, rsProjects.Build)
			rsProjects.FromJSON
		Case "E"
			'read record id
			Dim RecID As String = Record.Get("projectid")
			'initialize table for edit
			rsProjects.Initialize("bananocvc", "projects", "projectid", "projectid")
			'define schema for record
			rsProjects.SchemaFromDesign(dlgProjects.Container)
			'update a record
			rsProjects.Update1(Record, RecID)
			'generate & run command to update record
			rsProjects.JSON = BANano.CallInlinePHPWait(rsProjects.MethodName, rsProjects.Build)
			rsProjects.FromJSON
	End Select
	'hide the modal
	dlgProjects.Hide
	'lets create the folder to hold out custom views
	'create the project folder
	php.Initialize
	BANano.CallInlinePHPWait(php.DIRECTORY_MAKE, php.BuildDirectoryMake($"./customviews/${sprojectname}"$))
	'execute code to refresh listing for Projects
	vm.CallMethod("SelectAll_Projects")
End Sub

'add code to cancel the dialog for Project
Sub btnCancelProjects_click(e As BANanoEvent)
	'hide the modal
	dlgProjects.Hide
End Sub

Sub CreateDataTable_projects
	dtprojects = vm.CreateDataTable("dtprojects", "projectid", Me)
	dtprojects.SetTitle("Projects")
	dtprojects.SetSearchbox(True)
	dtprojects.SetAddNew("btnNewProject", "mdi-plus", "Add a new project")
	dtprojects.SetItemsperpage("10")
	dtprojects.SetMobilebreakpoint("600")
	dtprojects.SetMultisort(True)
	dtprojects.SetPage("1")
	dtprojects.SetSingleselect(True)
	dtprojects.SetVisible(True)
	'dtprojects.AddColumn1("projectid", "Projectid", "text",0,False,"start")
	dtprojects.AddColumn1("projectname", "Project Name", "text",0,True,"start")
	dtprojects.AddColumn1("projectauthor", "Project Author", "text",0,False,"start")
	dtprojects.AddColumn1("projectversion", "Project Version", "text",0,False,"start")
	dtprojects.AddColumn1("projectprefix", "Project Prefix", "text",0,False,"start")
	dtprojects.SetEdit(True)
	dtprojects.SetDelete(True)
	dtprojects.SetMenu(True)
	dtprojects.SetIconDimensions1("edit", "24px", "success","80")
	dtprojects.SetIconDimensions1("delete", "24px", "error","80")
	dtprojects.SetIconDimensions1("menu", "24px", "orange","80")
	cont.AddControl(dtprojects.DataTable, dtprojects.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)
End Sub