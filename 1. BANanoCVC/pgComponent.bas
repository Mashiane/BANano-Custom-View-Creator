B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.45
@EndOfDesignText@
'Static code module
#IgnoreWarnings:12
Sub Process_Globals
	Public Name As String = "pgComponentCode"
	Public Title As String = "Component"
	Private vm As BANanoVM
	Private vue As BANanoVue
	Private BANano As BANano  'ignore
	Private cont As VMContainer
	Private sprojectid As String
	Private sprojectname As String
	Private scomponentid As String
	Private scomponentname As String
	Private dlgAttributes As VMDialog
	Private dtattributes As VMDataTable
	Private Mode As String
	Private b4xCode As VMPrism
	Private dlgStyles As VMDialog
	Private dtstyles As VMDataTable
	Private dlgClasses As VMDialog
	Private dtclasses As VMDataTable
	Private dlgEvents As VMDialog
	Private dtevents As VMDataTable
End Sub

Sub Code
	'Establish a reference to the app
	vm = pgIndex.vm
	vue = vm.vue
	vm.setdata("projectname", "")
	vm.setdata("componentname", "")
	vm.Setdata("componentdescription", "")
	'create a container to hold all contents based on the page name
	cont = vm.CreateContainer(Name, Me)
	'the container should be hidden initialy
	cont.Hide
	'Add component here
	Dim lbl As VMLabel
	lbl.Initialize(vue, "lblCompProjectName").SetH2.SetText($"Project Name: {{ projectname }}"$)
	cont.AddControl(lbl.label, lbl.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)
	Dim lblc As VMLabel
	lblc.Initialize(vue, "lblComponentName").SetH3.SetText($"Component Tag: {{ componentdescription }} ({{ componentname }})"$)
	cont.AddControl(lblc.label, lblc.tostring, 2, 1, 0, 0, 0, 0, 12, 12, 12, 12)
	
	Dim tbstabs1 As VMTabs = vm.CreateTabs("tbstabs1", Me)
	tbstabs1.SetTabSlider(True)
	tbstabs1.SetIconsandtext(True)
	tbstabs1.SetMobilebreakpoint("1264")
	tbstabs1.SetVisible(True)
	tbstabs1.SetGrow(True)
	Dim conttabAttributes As VMContainer = CreateContainer_tabAttributes
	tbstabs1.AddTabBadge("tabAttributes", "Attributes", "mdi-shuriken", conttabAttributes, "0")  
	Dim conttabStyles As VMContainer = CreateContainer_tabStyles
	tbstabs1.AddTabBadge("tabStyles", "Styles", "mdi-middleware", conttabStyles,"0")   '
	Dim conttabClasses As VMContainer = CreateContainer_tabClasses
	tbstabs1.AddTabBadge("tabClasses", "Classes", "mdi-molecule", conttabClasses,"0")  '
	Dim conttabEvents As VMContainer = CreateContainer_tabEvents
	tbstabs1.AddTabBadge("tabEvents", "Events", "mdi-function", conttabEvents,"0")  '
	Dim conttabCode As VMContainer = CreateContainer_tabCode
	tbstabs1.AddTab("tabCode", "B4X Code", "mdi-code-braces", conttabCode)
	tbstabs1.SetOnChange(Me, "tabs_click")
	cont.AddControl(tbstabs1.Tabs, tbstabs1.tostring, 3, 1, 0, 0, 0, 0, 12, 12, 12, 12)
	'
	vm.SetBadgeOffsetX("tabAttributes", "-40")
	vm.SetBadgeOffsetY("tabAttributes", "20")
	'
	vm.SetBadgeOffsetX("tabStyles", "-40")
	vm.SetBadgeOffsetY("tabStyles", "20")
	'
	vm.SetBadgeOffsetX("tabClasses", "-40")
	vm.SetBadgeOffsetY("tabClasses", "20")
	'
	vm.SetBadgeOffsetX("tabEvents", "-40")
	vm.SetBadgeOffsetY("tabEvents", "20")
		
	'add container to the page
	vm.AddContainer(cont)
	'add the dialog to page
	CreateDialog_Attributes
	CreateDialog_Styles
	CreateDialog_Classes
	CreateDialog_Events
	'add method to get all records
	vm.SetMethod(Me, "SelectAll_Attributes")
	'add method to get all records
	vm.SetMethod(Me, "SelectAll_Styles")
	'add method to get all records
	vm.SetMethod(Me, "SelectAll_Classes")
	'add method to get all records
	vm.SetMethod(Me, "SelectAll_Events")
	Mode = ""
End Sub

Sub tabs_click(tabID As String)
	'source code for component
	Dim mproject As Map = vm.GetData("project")
	Dim mcomponent As Map =	vm.GetData("component")
	If BANano.IsNull(mproject) Or BANano.IsNull(mcomponent) Then Return
	'
	vm.SHowloading
	Dim cprojectid As String = mproject.getdefault("projectid","")
	Dim cprojectname As String = mproject.getdefault("projectname","")
	Dim cprojectprefix As String = mproject.getdefault("projectprefix", "")
	Dim cprojectversion As String = mproject.getdefault("projectversion", "")
	'
	Dim ccomponentdescription As String = mcomponent.getdefault("componentdescription","")
	Dim ccomponentid As String = mcomponent.GetDefault("componentid", "")
	Dim ccomponenttag As String = mcomponent.getdefault("componenttag", "")
	vm.setdata("componentdescription", ccomponentdescription)
	'get all attributes for component
	Dim rsAttributes As BANanoMySQLE
	rsAttributes.Initialize("bananocvc", "attributes", "attrid", "attrid")
	'generate & run command to select all records
	Dim aw As Map = CreateMap()
	aw.put("componentid", scomponentid)
	rsAttributes.SelectWhere("attributes", Array("*"), aw, Array("="), Array("attrname"))
	rsAttributes.JSON = BANano.CallInlinePHPWait(rsAttributes.MethodName, rsAttributes.Build)
	rsAttributes.FromJSON
	'get all styles for component
	Dim rsStyles As BANanoMySQLE
	rsStyles.Initialize("bananocvc", "styles", "styleid", "styleid")
	Dim aw As Map = CreateMap()
	aw.put("componentid", scomponentid)
	rsStyles.SelectWhere("styles", Array("*"), aw, Array("="), Array("stylename"))
	rsStyles.JSON = BANano.CallInlinePHPWait(rsStyles.MethodName, rsStyles.Build)
	rsStyles.FromJSON
	'get all classes for component
	Dim rsClasses As BANanoMySQLE
	rsClasses.Initialize("bananocvc", "classes", "classid", "classid")
	Dim aw As Map = CreateMap()
	aw.put("componentid", scomponentid)
	rsClasses.SelectWhere("classes", Array("*"), aw, Array("="), Array("classname"))
	rsClasses.JSON = BANano.CallInlinePHPWait(rsClasses.MethodName, rsClasses.Build)
	rsClasses.FromJSON
	'get all events for component
	Dim rsEvents As BANanoMySQLE
	rsEvents.Initialize("bananocvc", "events", "eventid", "eventid")
	Dim aw As Map = CreateMap()
	aw.put("componentid", scomponentid)
	rsEvents.SelectWhere("events", Array("*"), aw, Array("="), Array("eventname"))
	rsEvents.JSON = BANano.CallInlinePHPWait(rsEvents.MethodName, rsEvents.Build)
	rsEvents.FromJSON
	
	'beautify component name
	Dim bCompName As String = vm.BeautifyName(ccomponentdescription)
	'define file name
	Dim sCompName As String = $"${cprojectprefix}${bCompName}"$
	'
	Dim builder As clsBuilder
	builder.Initialize(vm, ccomponenttag, sCompName, rsAttributes.Result, rsStyles.Result, rsClasses.Result, rsEvents.Result)
	'
	Dim sb4xcode As String = builder.CreateCustomView
	b4xCode.SetCode(sb4xcode)
	'
	vue.Setdata("b4xCode", sb4xcode)
	vue.Setdata("filename", sCompName)
	
	vm.HideLoading
End Sub


'show the page
Sub Show
	'the navbar is visible for this page
	vm.NavBar.Show
	'show the hamburger for this page
	vm.NavBar.Hamburger.SetVisible(True)
	'the drawer should be hidden for this page
	vm.Drawer.Hide
	'the logo should be visible for this page
	vm.NavBar.Logo.Show
	'Show the page and hide others
	vm.ShowPage(Name)
	vm.HideItem("navProjects")
	vm.ShowItem("navComponents")
	'read the project details
	Dim project As Map = vm.GetData("project")
	sprojectid = project.get("projectid")
	sprojectname = project.get("projectname")
	'
	Dim component As Map = vm.getdata("component")
	scomponentname = component.get("componenttag")
	scomponentid = component.get("componentid")
	'
	vm.setdata("projectname", sprojectname)
	vm.setdata("projectid", sprojectid)
	'
	vm.setdata("componentname", scomponentname)
	vm.setdata("componentid", scomponentid)
	'
	'load records to table
	vm.CallMethod("SelectAll_Attributes")
	'load records to table
	vm.CallMethod("SelectAll_Styles")
	'load records to table
	vm.CallMethod("SelectAll_Classes")
	'load records to table
	vm.CallMethod("SelectAll_Events")
	b4xCode.SetCode("")
End Sub

'Create the Attributes tab
Sub CreateContainer_tabAttributes As VMContainer
	Dim conttabAttributes As VMContainer
	conttabAttributes = vm.CreateContainer("conttabAttributes", Me)
	'Add components for the container here!
	dtattributes = vm.CreateDataTable("dtattributes", "attrid", Me)
	dtattributes.SetTitle("Attributes")
	dtattributes.SetSearchbox(True)
	dtattributes.SetAddNew("btnNewAttributes", "mdi-plus", "Add a new attribute")
	dtattributes.SetItemsperpage("1000")
	dtattributes.SetMobilebreakpoint("600")
	dtattributes.SetMultisort(True)
	dtattributes.SetPage("1")
	dtattributes.SetSingleselect(True)
	dtattributes.SetVisible(True)
	dtattributes.AddColumn1("attrname", "Attribute", "text",0,False,"start")
	dtattributes.AddColumn1("defaultvalue", "Default", "text",0,False,"start")
	dtattributes.AddColumn1("attrtype", "Type", "text",0,False,"start")
	dtattributes.AddColumn1("attrdesigner", "Designer Property", "text",0,False,"start")
	dtattributes.AddColumn1("attrhasset", "Set", "text",0,False,"start")
	dtattributes.AddColumn1("attrhasget", "Get", "text",0,False,"start")
	dtattributes.AddColumn1("attronsub", "OnSub", "text",0,False,"start")
	dtattributes.AddColumn1("attroninit", "OnSignature", "text",0,False,"start")
	dtattributes.SetEdit(True)
	dtattributes.SetDelete(True)
	dtattributes.SetIconDimensions1("edit", "24px", "success", "80")
	dtattributes.SetIconDimensions1("delete", "24px", "error", "80")
	conttabAttributes.AddControl(dtattributes.DataTable, dtattributes.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)
	Return conttabAttributes
End Sub


'Create the Styles tab
Sub CreateContainer_tabStyles As VMContainer
	Dim conttabStyles As VMContainer
	conttabStyles = vm.CreateContainer("conttabStyles", Me)
	'Add components for the container here!
	dtstyles = vm.CreateDataTable("dtstyles", "styleid", Me)
	dtstyles.SetTitle("Styles")
	dtstyles.SetSearchbox(True)
	dtstyles.SetAddNew("btnNewStyle", "mdi-plus", "Add a new style")
	dtstyles.SetItemsperpage("1000")
	dtstyles.SetMobilebreakpoint("600")
	dtstyles.SetMultisort(True)
	dtstyles.SetPage("1")
	dtstyles.SetSingleselect(True)
	dtstyles.SetVisible(True)
	dtstyles.AddColumn1("stylename", "Style", "text",0,True,"start")
	dtstyles.AddColumn1("defaultvalue", "Default", "text",0,False,"start")
	dtstyles.AddColumn1("styletype", "Type", "text",0,True,"start")
	dtstyles.AddColumn1("styledesigner", "Designer Property", "text",0,False,"start")
	dtstyles.AddColumn1("stylehasset", "Set", "text",0,False,"start")
	dtstyles.AddColumn1("stylehasget", "Get", "text",0,False,"start")
	dtstyles.AddColumn1("styleonsub", "OnSub", "text",0,False,"start")
	dtstyles.AddColumn1("styleoninit", "OnSignature", "text",0,False,"start")
	dtstyles.SetEdit(True)
	dtstyles.SetDelete(True)
	dtstyles.SetClone(True) 
	dtstyles.SetIconDimensions1("edit", "24px", "success","80")
	dtstyles.SetIconDimensions1("delete", "24px", "error","80")
	dtstyles.SetIconDimensions1("clone", "24px", "orange","80")
	conttabStyles.AddControl(dtstyles.DataTable, dtstyles.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)
	Return conttabStyles
End Sub

'Create the codes tab
Sub CreateContainer_tabCode As VMContainer
	Dim conttabCode As VMContainer
	conttabCode = vm.CreateContainer("conttabCode", Me)
	'Add components for the container here!
	b4xCode.Initialize(vue, "b4xcode", Me)
	b4xCode.SetLanguage("vb")
	b4xCode.SetTitle("Custom View Source Code")
	b4xCode.SetCode("")
	conttabCode.AddControl(b4xCode.PrismComponent, b4xCode.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)
	Return conttabCode
End Sub

Sub b4xCodecopy_click(e As BANanoEvent)
	'get the component to process
	Dim sb4xCode As String = vue.getdata("b4xCode")
	Dim sfilename As String = vue.getdata("filename")
	vm.SaveText2File(sb4xCode, $"${sfilename}.bas"$)
End Sub


'Create the Classes tab
Sub CreateContainer_tabClasses As VMContainer
	Dim conttabClasses As VMContainer
	conttabClasses = vm.CreateContainer("conttabClasses", Me)
	'Add components for the container here!
	dtclasses = vm.CreateDataTable("dtclasses", "classid", Me)
	dtclasses.SetTitle("Classes")
	dtclasses.SetSearchbox(True)
	dtclasses.SetAddNew("btnNewClasse", "mdi-plus", "Add a new classe")
	dtclasses.SetItemsperpage("100")
	dtclasses.SetMobilebreakpoint("600")
	dtclasses.SetMultisort(True)
	dtclasses.SetPage("1")
	dtclasses.SetSingleselect(True)
	dtclasses.SetVisible(True)
	dtclasses.AddColumn1("classname", "Class", "text",0,True,"start")
	dtclasses.AddColumn1("defaultvalue", "Default", "text",0,False,"start")
	dtclasses.AddColumn1("classtype", "Type", "text",0,False,"start")
	dtclasses.AddColumn1("classdesigner", "Designer Property", "text",0,False,"start")
	dtclasses.AddColumn1("classhasset", "Set", "text",0,False,"start")
	dtclasses.AddColumn1("classhasget", "Get", "text",0,False,"start")
	dtclasses.AddColumn1("classonsub", "OnSub", "text",0,False,"start")
	dtclasses.AddColumn1("classoninit", "OnSignature", "text",0,False,"start")
	dtclasses.SetEdit(True)
	dtclasses.SetDelete(True)
	dtclasses.SetClone(True)
	dtclasses.SetIconDimensions1("edit", "24px", "success","80")
	dtclasses.SetIconDimensions1("delete", "24px", "error","80")
	dtclasses.SetIconDimensions1("clone", "24px", "orange","80")
	conttabClasses.AddControl(dtclasses.DataTable, dtclasses.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)
	Return conttabClasses
End Sub


'Create the Events tab
Sub CreateContainer_tabEvents As VMContainer
	Dim conttabEvents As VMContainer
	conttabEvents = vm.CreateContainer("conttabEvents", Me)
	'Add components for the container here!
	dtevents = vm.CreateDataTable("dtevents", "eventid", Me)
	dtevents.SetTitle("Events")
	dtevents.SetSearchbox(True)
	dtevents.SetAddNew("btnNewEvents", "mdi-plus", "Add a new events")
	dtevents.SetItemsperpage("10")
	dtevents.SetMobilebreakpoint("600")
	dtevents.SetMultisort(True)
	dtevents.SetPage("1")
	dtevents.SetSingleselect(True)
	dtevents.SetVisible(True)
	dtevents.AddColumn1("eventname", "Event Name", "text",0,True,"start")
	dtevents.AddColumn1("eventarguments", "Arguments", "text",0,False,"start")
	dtevents.AddColumn1("eventactive", "Active", "text",0,False,"start")
	dtevents.SetEdit(True)
	dtevents.SetDelete(True)
	dtevents.SetIconDimensions1("edit", "24px", "success","80")
	dtevents.SetIconDimensions1("delete", "24px", "error","80")
	conttabEvents.AddControl(dtevents.DataTable, dtevents.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)
	Return conttabEvents
End Sub

'delete all records
Sub DeleteAll_Attributes
	Dim rsAttributes As BANanoMySQLE
	'initialize table for table creation
	rsAttributes.Initialize("bananocvc", "attributes", "attrid", "attrid")
	rsAttributes.DeleteAll
	rsAttributes.JSON = BANano.CallInlinePHPWait(rsAttributes.MethodName, rsAttributes.Build)
	rsAttributes.FromJSON
	'execute code to refresh listing for Attributes
	vm.CallMethod("SelectAll_Attributes")
End Sub

'delete single record
Sub DeleteRecord_Attributes(RecordID As String)
	Dim rsAttributes As BANanoMySQLE
	'initialize table for deletion
	rsAttributes.Initialize("bananocvc", "attributes", "attrid", "attrid")
	'define schema for record
	rsAttributes.SchemaFromDesign(dlgAttributes.Container)
	'generate & run command to delete single record
	rsAttributes.Delete(RecordID)
	rsAttributes.JSON = BANano.CallInlinePHPWait(rsAttributes.MethodName, rsAttributes.Build)
	rsAttributes.FromJSON
	'execute code to refresh listing for Attributes
	vm.CallMethod("SelectAll_Attributes")
End Sub

'select all records
Sub SelectAll_Attributes
	Dim rsAttributes As BANanoMySQLE
	'initialize table for table creation
	rsAttributes.Initialize("bananocvc", "attributes", "attrid", "attrid")
	'generate & run command to select all records
	Dim aw As Map = CreateMap()
	aw.put("componentid", scomponentid)
	rsAttributes.SelectWhere("attributes", Array("*"), aw, Array("="), Array("attrname"))
	rsAttributes.JSON = BANano.CallInlinePHPWait(rsAttributes.MethodName, rsAttributes.Build)
	rsAttributes.FromJSON
	'save records to state
	vm.SetData("attributes", rsAttributes.Result)
	'update the data table records
	dtattributes.SetDataSource(rsAttributes.Result)
	Dim aCount As Int = rsAttributes.result.Size
	vm.SetBadgeContent("tabAttributes", aCount)
End Sub

'attributes Edit action
Sub dtattributes_edit(item As Map)
	'get the key
	Dim RecID As String = item.Get("attrid")
	If RecID = "" Then Return
	'set mode to E-dit
	Mode = "E"
	'read record from database
	Dim rsAttributes As BANanoMySQLE
	'initialize table for table creation
	rsAttributes.Initialize("bananocvc", "attributes", "attrid", "attrid")
	'define schema for record
	rsAttributes.SchemaFromDesign(dlgAttributes.Container)
	'generate & run command to read record
	rsAttributes.Read(RecID)
	rsAttributes.JSON = BANano.CallInlinePHPWait(rsAttributes.MethodName, rsAttributes.Build)
	rsAttributes.FromJSON
	'was the read successful?
	If rsAttributes.Result.Size = 0 Then Return
	'the record as found!
	Dim Record As Map = rsAttributes.result.get(0)
	'Update the dialog details
	dlgAttributes.SetTitle("Edit Attribute")
	'show the modal
	dlgAttributes.Show
	'update the state, this updates the v-model(s) for each input control
	vm.SetState(Record)
End Sub


'attributes Delete action
Sub dtattributes_delete(item As Map)
	'get the key
	Dim RecID As String = item.Get("attrid")
	If RecID = "" Then Return
	Dim attrname As String = item.get("attrname")
	'save the id to delete
	vm.SetData("attributesattrid", RecID)
	'show confirm dialog
	Dim sattrid As String = item.getdefault("attrid","")
	vm.ShowConfirm("delete_attributes", "Confirm Delete: " & attrname, _
"Are you sure that you want to delete this Attributes. You will not be able to undo your actions. Continue?","Ok","Cancel")
End Sub


'add a new Attributes
Sub AddAttributes
	'set mode to A-add
	Mode = "A"
	'update the title
	dlgAttributes.SetTitle("New Attribute")
	'show dialog
	dlgAttributes.Show
	vm.setdata("projectid", sprojectid)
	vm.setdata("componentid", scomponentid)
	vm.SetData("attroninit", "No")
	vm.SetData("attronsub", "No")
	vm.SetFocus("txtattrname")
End Sub


'when add new is clicked
Sub btnNewAttributes_click(e As BANanoEvent)
	AddAttributes
End Sub

'create dialog
Sub CreateDialog_Attributes
	dlgAttributes = vm.CreateDialog("dlgAttributes", Me)
	dlgAttributes.SetTitle("Attributes")
	dlgAttributes.SetOk("btnOkAttributes","Save")
	dlgAttributes.SetCancel("btnCancelAttributes","Cancel")
	dlgAttributes.Setwidth("800px")
	dlgAttributes.Setpersistent(True)
	'*** Add code to create components below this line!
	
	'INSTRUCTION: Copy & paste the code below to where your "dlgAttributes.Container" is being built!

	Dim txtattrid As VMTextField = vm.NewTextField(Me, False, "txtattrid", "attrid", "Attrid", "", False, "", 11, "", "", 0)
	txtattrid.SetFieldType("int")
	txtattrid.SetVisible(False)
	dlgAttributes.Container.AddControl(txtattrid.textfield, txtattrid.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgAttributes.Container" is being built!

	Dim txtprojectid As VMTextField = vm.NewTextField(Me, False, "txtprojectid", "projectid", "Projectid", "", False, "", 11, "", "", 0)
	txtprojectid.SetFieldType("int")
	txtprojectid.SetVisible(False)
	dlgAttributes.Container.AddControl(txtprojectid.textfield, txtprojectid.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgAttributes.Container" is being built!

	Dim txtcomponentid As VMTextField = vm.NewTextField(Me, False, "txtcomponentid", "componentid", "Componentid", "", False, "", 11, "", "", 0)
	txtcomponentid.SetFieldType("int")
	txtcomponentid.SetVisible(False)
	dlgAttributes.Container.AddControl(txtcomponentid.textfield, txtcomponentid.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgAttributes.Container" is being built!

	Dim txtattrname As VMTextField = vm.NewTextField(Me, False, "txtattrname", "attrname", "Attribute", "", True, "", 0, "", "The attribute is required!", 0)
	txtattrname.SetFieldType("string")
	txtattrname.SetAutoFocus(True)
	txtattrname.SetVisible(True)
	dlgAttributes.Container.AddControl(txtattrname.textfield, txtattrname.tostring, 2, 1, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgAttributes.Container" is being built!

	Dim txtdefaultvalue As VMTextField = vm.NewTextField(Me, False, "txtdefaultvalue", "defaultvalue", "Default Value", "", False, "", 0, "", "", 0)
	txtdefaultvalue.SetFieldType("string")
	txtdefaultvalue.SetHideDetails(True)
	txtdefaultvalue.SetVisible(True)
	dlgAttributes.Container.AddControl(txtdefaultvalue.textfield, txtdefaultvalue.tostring, 2, 2, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgAttributes.Container" is being built!

	Dim attrtypekeys As String = "String,Int,Boolean"
	Dim attrtypevalues As String = "String,Int,Boolean"
	Dim attrtypemap As Map = vm.keyvalues2map(",", attrtypekeys, attrtypevalues)
	Dim rdattrtype As VMRadioGroup = vm.NewRadioGroup(Me, False, "rdattrtype", "attrtype", "Type", "String", attrtypemap, True, False, 0)
	rdattrtype.SetFieldType("string")
	rdattrtype.SetVisible(True)
	dlgAttributes.Container.AddControl(rdattrtype.RadioGroup, rdattrtype.tostring, 3, 1, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgAttributes.Container" is being built!

	Dim swtattrdesigner As VMCheckBox = vm.NewSwitch(Me, False, "swtattrdesigner", "attrdesigner", "Designer Property", "Yes", "No", False, 0)
	swtattrdesigner.SetFieldType("string")
	swtattrdesigner.SetVisible(True)
	dlgAttributes.Container.AddControl(swtattrdesigner.CheckBox, swtattrdesigner.tostring, 3, 2, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgAttributes.Container" is being built!

	Dim txtattrdescription As VMTextField = vm.NewTextField(Me, False, "txtattrdescription", "attrdescription", "Description", "", False, "", 200, "", "", 0)
	txtattrdescription.SetFieldType("string")
	txtattrdescription.SetHideDetails(True)
	txtattrdescription.SetVisible(True)
	dlgAttributes.Container.AddControl(txtattrdescription.textfield, txtattrdescription.tostring, 4, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgAttributes.Container" is being built!

	Dim txtattroptions As VMTextField = vm.NewTextField(Me, False, "txtattroptions", "attroptions", "Options", "", False, "", 0, "", "", 0)
	txtattroptions.SetFieldType("string")
	txtattroptions.SetHideDetails(True)
	txtattroptions.SetVisible(True)
	dlgAttributes.Container.AddControl(txtattroptions.textfield, txtattroptions.tostring, 5, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgAttributes.Container" is being built!

	Dim swtattrhasset As VMCheckBox = vm.NewSwitch(Me, False, "swtattrhasset", "attrhasset", "Has Set", "Yes", "No", False, 0)
	swtattrhasset.SetFieldType("string")
	swtattrhasset.SetVisible(True)
	dlgAttributes.Container.AddControl(swtattrhasset.CheckBox, swtattrhasset.tostring, 6, 1, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgAttributes.Container" is being built!

	Dim swtattrhasget As VMCheckBox = vm.NewSwitch(Me, False, "swtattrhasget", "attrhasget", "Has Get", "Yes", "No", False, 0)
	swtattrhasget.SetFieldType("string")
	swtattrhasget.SetVisible(True)
	dlgAttributes.Container.AddControl(swtattrhasget.CheckBox, swtattrhasget.tostring, 6, 2, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgAttributes.Container" is being built!

	Dim txtattrmin As VMTextField = vm.NewTextField(Me, False, "txtattrmin", "attrmin", "Min Value", "", False, "", 0, "", "", 0)
	txtattrmin.SetFieldType("string")
	txtattrmin.SetVisible(True)
	dlgAttributes.Container.AddControl(txtattrmin.textfield, txtattrmin.tostring, 7, 1, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgAttributes.Container" is being built!

	Dim txtattrmax As VMTextField = vm.NewTextField(Me, False, "txtattrmax", "attrmax", "Max Value", "", False, "", 0, "", "", 0)
	txtattrmax.SetFieldType("string")
	txtattrmax.SetVisible(True)
	dlgAttributes.Container.AddControl(txtattrmax.textfield, txtattrmax.tostring, 7, 2, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgAttributes.Container" is being built!

	Dim swtattronsub As VMCheckBox = vm.NewSwitch(Me, False, "swtattronsub", "attronsub", "On Sub", "Yes", "No", False, 0)
	swtattronsub.SetFieldType("string")
	swtattronsub.SetVisible(True)
	dlgAttributes.Container.AddControl(swtattronsub.CheckBox, swtattronsub.tostring, 8, 1, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgAttributes.Container" is being built!

	Dim swtattroninit As VMCheckBox = vm.NewSwitch(Me, False, "swtattroninit", "attroninit", "On Signature", "Yes", "No", False, 0)
	swtattroninit.SetFieldType("string")
	swtattroninit.SetVisible(True)
	dlgAttributes.Container.AddControl(swtattroninit.CheckBox, swtattroninit.tostring, 8, 2, 0, 0, 0, 0, 12, 6, 6, 6)


	vm.AddDialog(dlgAttributes)
End Sub

'add code to save the Attributes
Sub btnOkAttributes_click(e As BANanoEvent)
	'create/update record to table
	'get the record to create/update
	Dim Record As Map = dlgAttributes.Container.GetData
	'validate the record
	Dim bValid As Boolean = vm.Validate(Record, dlgAttributes.Container.Required)
	'if invalid exit create/update
	If bValid = False Then
		Dim strError As String = vue.GetError
		vm.ShowSnackBarError(strError)
		Return
	End If
	'resultset variable
	Dim rsAttributes As BANanoMySQLE
	'check mode
	Select Case Mode
		Case "A"
			'initialize table for insert
			rsAttributes.Initialize("bananocvc", "attributes", "attrid", "attrid")
			'define schema for record
			rsAttributes.SchemaFromDesign(dlgAttributes.Container)
			'insert a record
			rsAttributes.Insert1(Record)
			'generate & run command to insert record
			rsAttributes.JSON = BANano.CallInlinePHPWait(rsAttributes.MethodName, rsAttributes.Build)
			rsAttributes.FromJSON
		Case "E"
			'read record id
			Dim RecID As String = Record.Get("attrid")
			'initialize table for edit
			rsAttributes.Initialize("bananocvc", "attributes", "attrid", "attrid")
			'define schema for record
			rsAttributes.SchemaFromDesign(dlgAttributes.Container)
			'update a record
			rsAttributes.Update1(Record, RecID)
			'generate & run command to update record
			rsAttributes.JSON = BANano.CallInlinePHPWait(rsAttributes.MethodName, rsAttributes.Build)
			rsAttributes.FromJSON
	End Select
	'hide the modal
	dlgAttributes.Hide
	'execute code to refresh listing for Attributes
	vm.CallMethod("SelectAll_Attributes")
End Sub

'add code to cancel the dialog for Attributes
Sub btnCancelAttributes_click(e As BANanoEvent)
	'hide the modal
	dlgAttributes.Hide
End Sub

'delete all records
Sub DeleteAll_Styles
	Dim rsStyles As BANanoMySQLE
	'initialize table for table creation
	rsStyles.Initialize("bananocvc", "styles", "styleid", "styleid")
	rsStyles.DeleteAll
	rsStyles.JSON = BANano.CallInlinePHPWait(rsStyles.MethodName, rsStyles.Build)
	rsStyles.FromJSON
	'execute code to refresh listing for Styles
	vm.CallMethod("SelectAll_Styles")
End Sub

'delete single record
Sub DeleteRecord_Styles(RecordID As String)
	Dim rsStyles As BANanoMySQLE
	'initialize table for deletion
	rsStyles.Initialize("bananocvc", "styles", "styleid", "styleid")
	'define schema for record
	rsStyles.SchemaFromDesign(dlgStyles.Container)
	'generate & run command to delete single record
	rsStyles.Delete(RecordID)
	rsStyles.JSON = BANano.CallInlinePHPWait(rsStyles.MethodName, rsStyles.Build)
	rsStyles.FromJSON
	'execute code to refresh listing for Styles
	vm.CallMethod("SelectAll_Styles")
End Sub

'select all records
Sub SelectAll_Styles
	Dim rsStyles As BANanoMySQLE
	'initialize table for table creation
	rsStyles.Initialize("bananocvc", "styles", "styleid", "styleid")
	Dim aw As Map = CreateMap()
	aw.put("componentid", scomponentid)
	rsStyles.SelectWhere("styles", Array("*"), aw, Array("="), Array("stylename"))
	rsStyles.JSON = BANano.CallInlinePHPWait(rsStyles.MethodName, rsStyles.Build)
	rsStyles.FromJSON
	'save records to state
	vm.SetData("styles", rsStyles.Result)
	'update the data table records
	dtstyles.SetDataSource(rsStyles.Result)
	Dim aCount As Int = rsStyles.result.Size
	vm.SetBadgeContent("tabStyles", aCount)
End Sub

'styles Edit action
Sub dtstyles_edit(item As Map)
	'get the key
	Dim RecID As String = item.Get("styleid")
	If RecID = "" Then Return
	'set mode to E-dit
	Mode = "E"
	'read record from database
	Dim rsStyles As BANanoMySQLE
	'initialize table for table creation
	rsStyles.Initialize("bananocvc", "styles", "styleid", "styleid")
	'define schema for record
	rsStyles.SchemaFromDesign(dlgStyles.Container)
	'generate & run command to read record
	rsStyles.Read(RecID)
	rsStyles.JSON = BANano.CallInlinePHPWait(rsStyles.MethodName, rsStyles.Build)
	rsStyles.FromJSON
	'was the read successful?
	If rsStyles.Result.Size = 0 Then Return
	'the record as found!
	Dim Record As Map = rsStyles.result.get(0)
	'Update the dialog details
	dlgStyles.SetTitle("Edit Style")
	'show the modal
	dlgStyles.Show
	'update the state, this updates the v-model(s) for each input control
	vm.SetState(Record)
End Sub


'styles Delete action
Sub dtstyles_delete(item As Map)
	'get the key
	Dim RecID As String = item.Get("styleid")
	If RecID = "" Then Return
	'save the id to delete
	vm.SetData("stylesstyleid", RecID)
	'show confirm dialog
	Dim sstylename As String = item.getdefault("stylename","")
	vm.ShowConfirm("delete_styles", "Confirm Delete: " & sstylename, _
"Are you sure that you want to delete this Style. You will not be able to undo your actions. Continue?","Ok","Cancel")
End Sub


'styles Clone action
Sub dtstyles_clone(item As Map)
	'get the key
	Dim RecID As String = item.Get("styleid")
	If RecID = "" Then Return
	'set mode to A-dd
	Mode = "A"
	'read existing record from database
	Dim rsStyles As BANanoMySQLE
	'initialize table for table creation
	rsStyles.Initialize("bananocvc", "styles", "styleid", "styleid")
	'define schema for record
	rsStyles.SchemaFromDesign(dlgStyles.Container)
	'generate & run command to read record
	rsStyles.Read(RecID)
	rsStyles.JSON = BANano.CallInlinePHPWait(rsStyles.MethodName, rsStyles.Build)
	rsStyles.FromJSON
	'was the read successful?
	If rsStyles.Result.Size = 0 Then Return
	'the record as found!
	Dim Record As Map = rsStyles.Result.Get(0)
	'nullify key
	Record.put("styleid", Null)
	'Update the dialog details
	dlgStyles.SetTitle("New Style")
	'show the modal
	dlgStyles.Show
	'update the state, this updates the v-model(s) for each input control
	vm.SetState(Record)
End Sub


'add a new Style
Sub AddStyles
	'set mode to A-add
	Mode = "A"
	'update the title
	dlgStyles.SetTitle("New Style")
	'show dialog
	dlgStyles.Show
	vm.setdata("projectid", sprojectid)
	vm.setdata("componentid", scomponentid)
	vm.SetData("styleoninit", "No")
	vm.SetData("styleonsub", "No")
	vm.SetFocus("txtstylename")
End Sub


'when add new is clicked
Sub btnNewStyle_click(e As BANanoEvent)
	AddStyles
End Sub

'create dialog
Sub CreateDialog_Styles
	dlgStyles = vm.CreateDialog("dlgStyles", Me)
	dlgStyles.SetTitle("Styles")
	dlgStyles.SetOk("btnOkStyles","Save")
	dlgStyles.SetCancel("btnCancelStyles","Cancel")
	dlgStyles.Setwidth("700px")
	dlgStyles.Setpersistent(True)
	'*** Add code to create components below this line!
	'INSTRUCTION: Copy & paste the Code below To where your "dlgStyles.Container" Is being built!
	
	Dim txtstyleid As VMTextField = vm.NewTextField(Me, False, "txtstyleid", "styleid", "Styleid", "", False, "", 11, "", "", 0)
	txtstyleid.SetFieldType("int")
	txtstyleid.SetVisible(False)
	dlgStyles.Container.AddControl(txtstyleid.textfield, txtstyleid.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgStyles.Container" is being built!

	Dim txtprojectid As VMTextField = vm.NewTextField(Me, False, "txtprojectid", "projectid", "Projectid", "", False, "", 11, "", "", 0)
	txtprojectid.SetFieldType("int")
	txtprojectid.SetVisible(False)
	dlgStyles.Container.AddControl(txtprojectid.textfield, txtprojectid.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgStyles.Container" is being built!

	Dim txtcomponentid As VMTextField = vm.NewTextField(Me, False, "txtcomponentid", "componentid", "Componentid", "", False, "", 11, "", "", 0)
	txtcomponentid.SetFieldType("int")
	txtcomponentid.SetVisible(False)
	dlgStyles.Container.AddControl(txtcomponentid.textfield, txtcomponentid.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgStyles.Container" is being built!

	Dim txtstylemin As VMTextField = vm.NewTextField(Me, False, "txtstylemin", "stylemin", "Stylemin", "", False, "", 5, "", "", 0)
	txtstylemin.SetFieldType("string")
	txtstylemin.SetVisible(False)
	dlgStyles.Container.AddControl(txtstylemin.textfield, txtstylemin.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgStyles.Container" is being built!

	Dim txtstylemax As VMTextField = vm.NewTextField(Me, False, "txtstylemax", "stylemax", "Stylemax", "", False, "", 0, "", "", 0)
	txtstylemax.SetFieldType("string")
	txtstylemax.SetVisible(False)
	dlgStyles.Container.AddControl(txtstylemax.textfield, txtstylemax.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgStyles.Container" is being built!

	Dim txtstylename As VMTextField = vm.NewTextField(Me, False, "txtstylename", "stylename", "Style", "", True, "", 0, "", "The style is required!", 0)
	txtstylename.SetFieldType("string")
	txtstylename.SetAutoFocus(True)
	txtstylename.SetVisible(True)
	dlgStyles.Container.AddControl(txtstylename.textfield, txtstylename.tostring, 2, 1, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgStyles.Container" is being built!

	Dim txtdefaultvalue As VMTextField = vm.NewTextField(Me, False, "txtdefaultvalue", "defaultvalue", "Default Value", "", False, "", 0, "", "The default value is required!", 0)
	txtdefaultvalue.SetFieldType("string")
	txtdefaultvalue.SetVisible(True)
	dlgStyles.Container.AddControl(txtdefaultvalue.textfield, txtdefaultvalue.tostring, 2, 2, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgStyles.Container" is being built!
	Dim styletypekeys As String = "String,Int,Boolean"
	Dim styletypevalues As String = "String,Int,Boolean"
	Dim styletypemap As Map = vm.keyvalues2map(",", styletypekeys, styletypevalues)
	Dim rdstyletype As VMRadioGroup = vm.NewRadioGroup(Me, False, "rdstyletype", "styletype", "Type", "String", styletypemap, True, False, 0)
	rdstyletype.SetFieldType("string")
	rdstyletype.SetVisible(True)
	rdstyletype.SetDisabled(True)	
	dlgStyles.Container.AddControl(rdstyletype.RadioGroup, rdstyletype.tostring, 3, 1, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgStyles.Container" is being built!

	Dim swtstyledesigner As VMCheckBox = vm.NewSwitch(Me, False, "swtstyledesigner", "styledesigner", "Designer Property", "Yes", "No", False, 0)
	swtstyledesigner.SetFieldType("string")
	swtstyledesigner.SetValue("Yes")
	swtstyledesigner.SetVisible(True)
	dlgStyles.Container.AddControl(swtstyledesigner.CheckBox, swtstyledesigner.tostring, 3, 2, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgStyles.Container" is being built!

	Dim txtstyledescription As VMTextField = vm.NewTextField(Me, False, "txtstyledescription", "styledescription", "Description", "", False, "", 200, "", "", 0)
	txtstyledescription.SetFieldType("string")
	txtstyledescription.SetVisible(True)
	dlgStyles.Container.AddControl(txtstyledescription.textfield, txtstyledescription.tostring, 4, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgStyles.Container" is being built!

	Dim txtstyleoptions As VMTextField = vm.NewTextField(Me, False, "txtstyleoptions", "styleoptions", "Options", "", False, "", 0, "", "", 0)
	txtstyleoptions.SetFieldType("string")
	txtstyleoptions.SetVisible(True)
	dlgStyles.Container.AddControl(txtstyleoptions.textfield, txtstyleoptions.tostring, 5, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgStyles.Container" is being built!

	Dim swtstylehasset As VMCheckBox = vm.NewSwitch(Me, False, "swtstylehasset", "stylehasset", "Has Set", "Yes", "No", False, 0)
	swtstylehasset.SetFieldType("string")
	swtstylehasset.SetValue("Yes")
	swtstylehasset.SetVisible(True)
	dlgStyles.Container.AddControl(swtstylehasset.CheckBox, swtstylehasset.tostring, 6, 1, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgStyles.Container" is being built!

	Dim swtstylehasget As VMCheckBox = vm.NewSwitch(Me, False, "swtstylehasget", "stylehasget", "Has Get", "Yes", "No", False, 0)
	swtstylehasget.SetFieldType("string")
	swtstylehasget.SetValue("Yes")
	swtstylehasget.SetVisible(True)
	dlgStyles.Container.AddControl(swtstylehasget.CheckBox, swtstylehasget.tostring, 6, 2, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgStyles.Container" is being built!

	Dim swtstyleonsub As VMCheckBox = vm.NewSwitch(Me, False, "swtstyleonsub", "styleonsub", "On Sub", "Yes", "No", False, 0)
	swtstyleonsub.SetFieldType("string")
	swtstyleonsub.SetValue("Yes")
	swtstyleonsub.SetVisible(True)
	dlgStyles.Container.AddControl(swtstyleonsub.CheckBox, swtstyleonsub.tostring, 7, 1, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgStyles.Container" is being built!

	Dim swtstyleoninit As VMCheckBox = vm.NewSwitch(Me, False, "swtstyleoninit", "styleoninit", "On Signature", "Yes", "No", False, 0)
	swtstyleoninit.SetFieldType("string")
	swtstyleoninit.SetValue("Yes")
	swtstyleoninit.SetVisible(True)
	dlgStyles.Container.AddControl(swtstyleoninit.CheckBox, swtstyleoninit.tostring, 7, 2, 0, 0, 0, 0, 12, 6, 6, 6)

	vm.AddDialog(dlgStyles)
End Sub

'add code to save the Style
Sub btnOkStyles_click(e As BANanoEvent)
	'create/update record to table
	'get the record to create/update
	Dim Record As Map = dlgStyles.Container.GetData
	'validate the record
	Dim bValid As Boolean = vm.Validate(Record, dlgStyles.Container.Required)
	'if invalid exit create/update
	If bValid = False Then
		Dim strError As String = vue.GetError
		vm.ShowSnackBarError(strError)
		Return
	End If
	'resultset variable
	Dim rsStyles As BANanoMySQLE
	'check mode
	Select Case Mode
		Case "A"
			'initialize table for insert
			rsStyles.Initialize("bananocvc", "styles", "styleid", "styleid")
			'define schema for record
			rsStyles.SchemaFromDesign(dlgStyles.Container)
			'insert a record
			rsStyles.Insert1(Record)
			'generate & run command to insert record
			rsStyles.JSON = BANano.CallInlinePHPWait(rsStyles.MethodName, rsStyles.Build)
			rsStyles.FromJSON
		Case "E"
			'read record id
			Dim RecID As String = Record.Get("styleid")
			'initialize table for edit
			rsStyles.Initialize("bananocvc", "styles", "styleid", "styleid")
			'define schema for record
			rsStyles.SchemaFromDesign(dlgStyles.Container)
			'update a record
			rsStyles.Update1(Record, RecID)
			'generate & run command to update record
			rsStyles.JSON = BANano.CallInlinePHPWait(rsStyles.MethodName, rsStyles.Build)
			rsStyles.FromJSON
	End Select
	'hide the modal
	dlgStyles.Hide
	'execute code to refresh listing for Styles
	vm.CallMethod("SelectAll_Styles")
End Sub

'add code to cancel the dialog for Style
Sub btnCancelStyles_click(e As BANanoEvent)
	'hide the modal
	dlgStyles.Hide
End Sub

'delete all records
Sub DeleteAll_Classes
	Dim rsClasses As BANanoMySQLE
	'initialize table for table creation
	rsClasses.Initialize("bananocvc", "classes", "classid", "classid")
	rsClasses.DeleteAll
	rsClasses.JSON = BANano.CallInlinePHPWait(rsClasses.MethodName, rsClasses.Build)
	rsClasses.FromJSON
	'execute code to refresh listing for Classes
	vm.CallMethod("SelectAll_Classes")
End Sub

'delete single record
Sub DeleteRecord_Classes(RecordID As String)
	Dim rsClasses As BANanoMySQLE
	'initialize table for deletion
	rsClasses.Initialize("bananocvc", "classes", "classid", "classid")
	'define schema for record
	rsClasses.SchemaFromDesign(dlgClasses.Container)
	'generate & run command to delete single record
	rsClasses.Delete(RecordID)
	rsClasses.JSON = BANano.CallInlinePHPWait(rsClasses.MethodName, rsClasses.Build)
	rsClasses.FromJSON
	'execute code to refresh listing for Classes
	vm.CallMethod("SelectAll_Classes")
End Sub

'select all records
Sub SelectAll_Classes
	Dim rsClasses As BANanoMySQLE
	'initialize table for table creation
	rsClasses.Initialize("bananocvc", "classes", "classid", "classid")
	Dim aw As Map = CreateMap()
	aw.put("componentid", scomponentid)
	rsClasses.SelectWhere("classes", Array("*"), aw, Array("="), Array("classname"))
	rsClasses.JSON = BANano.CallInlinePHPWait(rsClasses.MethodName, rsClasses.Build)
	rsClasses.FromJSON
	'save records to state
	vm.SetData("classes", rsClasses.Result)
	'update the data table records
	dtclasses.SetDataSource(rsClasses.Result)
	Dim aCount As Int = rsClasses.result.Size
	vm.SetBadgeContent("tabClasses", aCount)
End Sub

'classes Edit action
Sub dtclasses_edit(item As Map)
	'get the key
	Dim RecID As String = item.Get("classid")
	If RecID = "" Then Return
	'set mode to E-dit
	Mode = "E"
	'read record from database
	Dim rsClasses As BANanoMySQLE
	'initialize table for table creation
	rsClasses.Initialize("bananocvc", "classes", "classid", "classid")
	'define schema for record
	rsClasses.SchemaFromDesign(dlgClasses.Container)
	'generate & run command to read record
	rsClasses.Read(RecID)
	rsClasses.JSON = BANano.CallInlinePHPWait(rsClasses.MethodName, rsClasses.Build)
	rsClasses.FromJSON
	'was the read successful?
	If rsClasses.Result.Size = 0 Then Return
	'the record as found!
	Dim Record As Map = rsClasses.result.get(0)
	'Update the dialog details
	dlgClasses.SetTitle("Edit Class")
	'show the modal
	dlgClasses.Show
	'update the state, this updates the v-model(s) for each input control
	vm.SetState(Record)
End Sub


'classes Delete action
Sub dtclasses_delete(item As Map)
	'get the key
	Dim RecID As String = item.Get("classid")
	If RecID = "" Then Return
	'save the id to delete
	vm.SetData("classesclassid", RecID)
	'show confirm dialog
	Dim sclassname As String = item.getdefault("classname","")
	vm.ShowConfirm("delete_classes", "Confirm Delete: " & sclassname, _
"Are you sure that you want to delete this Classe. You will not be able to undo your actions. Continue?","Ok","Cancel")
End Sub


'add a new Classe
Sub AddClasses
	'set mode to A-add
	Mode = "A"
	'update the title
	dlgClasses.SetTitle("New Class")
	'show dialog
	dlgClasses.Show
	vm.setdata("projectid", sprojectid)
	vm.setdata("componentid", scomponentid)
	vm.SetData("classoninit", "No")
	vm.SetData("classonsub", "No")
	vm.SetFocus("txtclassname")
End Sub


'when add new is clicked
Sub btnNewClasse_click(e As BANanoEvent)
	AddClasses
End Sub

'create dialog
Sub CreateDialog_Classes
	dlgClasses = vm.CreateDialog("dlgClasses", Me)
	dlgClasses.SetTitle("Classes")
	dlgClasses.SetOk("btnOkClasses","Save")
	dlgClasses.SetCancel("btnCancelClasses","Cancel")
	dlgClasses.Setwidth("700px")
	dlgClasses.Setpersistent(True)
	'*** Add code to create components below this line!

	
	Dim txtclassid As VMTextField = vm.NewTextField(Me, False, "txtclassid", "classid", "Classid", "", False, "", 11, "", "", 0)
	txtclassid.SetFieldType("int")
	txtclassid.SetVisible(False)
	dlgClasses.Container.AddControl(txtclassid.textfield, txtclassid.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgClasses.Container" is being built!

	Dim txtprojectid As VMTextField = vm.NewTextField(Me, False, "txtprojectid", "projectid", "Projectid", "", False, "", 11, "", "", 0)
	txtprojectid.SetFieldType("int")
	txtprojectid.SetVisible(False)
	dlgClasses.Container.AddControl(txtprojectid.textfield, txtprojectid.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgClasses.Container" is being built!

	Dim txtcomponentid As VMTextField = vm.NewTextField(Me, False, "txtcomponentid", "componentid", "Componentid", "", False, "", 11, "", "", 0)
	txtcomponentid.SetFieldType("int")
	txtcomponentid.SetVisible(False)
	dlgClasses.Container.AddControl(txtcomponentid.textfield, txtcomponentid.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgClasses.Container" is being built!

	Dim txtclassname As VMTextField = vm.NewTextField(Me, False, "txtclassname", "classname", "Class", "", True, "", 0, "", "The class is required!", 0)
	txtclassname.SetFieldType("string")
	txtclassname.SetDense(True)
	txtclassname.SetAutoFocus(True)
	txtclassname.SetVisible(True)
	dlgClasses.Container.AddControl(txtclassname.textfield, txtclassname.tostring, 2, 1, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgClasses.Container" is being built!

	Dim txtdefaultvalue As VMTextField = vm.NewTextField(Me, False, "txtdefaultvalue", "defaultvalue", "Default", "", False, "", 0, "", "", 0)
	txtdefaultvalue.SetFieldType("string")
	txtdefaultvalue.SetDense(True)
	txtdefaultvalue.SetVisible(True)
	dlgClasses.Container.AddControl(txtdefaultvalue.textfield, txtdefaultvalue.tostring, 2, 2, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgClasses.Container" is being built!
	Dim classtypekeys As String = "String,Int,Boolean"
	Dim classtypevalues As String = "String,Int,Boolean"
	Dim classtypemap As Map = vm.keyvalues2map(",", classtypekeys, classtypevalues)
	Dim rdclasstype As VMRadioGroup = vm.NewRadioGroup(Me, False, "rdclasstype", "classtype", "Type", "String", classtypemap, True, False, 0)
	rdclasstype.SetFieldType("string")
	rdclasstype.SetDense(True)
	rdclasstype.SetVisible(True)
	rdclasstype.SetDisabled(True)
	dlgClasses.Container.AddControl(rdclasstype.RadioGroup, rdclasstype.tostring, 3, 1, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgClasses.Container" is being built!

	Dim swtclassdesigner As VMCheckBox = vm.NewSwitch(Me, False, "swtclassdesigner", "classdesigner", "Designer Property", "Yes", "No", False, 0)
	swtclassdesigner.SetFieldType("string")
	swtclassdesigner.SetValue("Yes")
	swtclassdesigner.SetDense(True)
	swtclassdesigner.SetVisible(True)
	dlgClasses.Container.AddControl(swtclassdesigner.CheckBox, swtclassdesigner.tostring, 3, 2, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgClasses.Container" is being built!

	Dim txtclassdescription As VMTextField = vm.NewTextField(Me, False, "txtclassdescription", "classdescription", "Description", "", False, "", 200, "", "", 0)
	txtclassdescription.SetFieldType("string")
	txtclassdescription.SetDense(True)
	txtclassdescription.SetVisible(True)
	dlgClasses.Container.AddControl(txtclassdescription.textfield, txtclassdescription.tostring, 4, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgClasses.Container" is being built!

	Dim txtclassoptions As VMTextField = vm.NewTextField(Me, False, "txtclassoptions", "classoptions", "Options", "", False, "", 0, "", "", 0)
	txtclassoptions.SetFieldType("string")
	txtclassoptions.SetDense(True)
	txtclassoptions.SetVisible(True)
	txtclassoptions.SetTextArea
	dlgClasses.Container.AddControl(txtclassoptions.textfield, txtclassoptions.tostring, 5, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgClasses.Container" is being built!

	Dim swtclasshasset As VMCheckBox = vm.NewSwitch(Me, False, "swtclasshasset", "classhasset", "Set", "Yes", "No", False, 0)
	swtclasshasset.SetFieldType("string")
	swtclasshasset.SetValue("Yes")
	swtclasshasset.SetDense(True)
	swtclasshasset.SetVisible(True)
	dlgClasses.Container.AddControl(swtclasshasset.CheckBox, swtclasshasset.tostring, 6, 1, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgClasses.Container" is being built!

	Dim swtclasshasget As VMCheckBox = vm.NewSwitch(Me, False, "swtclasshasget", "classhasget", "Get", "Yes", "No", False, 0)
	swtclasshasget.SetFieldType("string")
	swtclasshasget.SetValue("Yes")
	swtclasshasget.SetDense(True)
	swtclasshasget.SetVisible(True)
	dlgClasses.Container.AddControl(swtclasshasget.CheckBox, swtclasshasget.tostring, 6, 2, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgClasses.Container" is being built!

	Dim txtclassmin As VMTextField = vm.NewTextField(Me, False, "txtclassmin", "classmin", "Min Range", "", False, "", 0, "", "", 0)
	txtclassmin.SetFieldType("string")
	txtclassmin.SetDense(True)
	txtclassmin.SetVisible(True)
	dlgClasses.Container.AddControl(txtclassmin.textfield, txtclassmin.tostring, 7, 1, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgClasses.Container" is being built!

	Dim txtclassmax As VMTextField = vm.NewTextField(Me, False, "txtclassmax", "classmax", "Max Range", "", False, "", 0, "", "", 0)
	txtclassmax.SetFieldType("string")
	txtclassmax.SetDense(True)
	txtclassmax.SetVisible(True)
	dlgClasses.Container.AddControl(txtclassmax.textfield, txtclassmax.tostring, 7, 2, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgClasses.Container" is being built!

	Dim swtclassonsub As VMCheckBox = vm.NewSwitch(Me, False, "swtclassonsub", "classonsub", "OnSub", "Yes", "No", False, 0)
	swtclassonsub.SetFieldType("string")
	swtclassonsub.SetValue("Yes")
	swtclassonsub.SetDense(True)
	swtclassonsub.SetVisible(True)
	dlgClasses.Container.AddControl(swtclassonsub.CheckBox, swtclassonsub.tostring, 8, 1, 0, 0, 0, 0, 12, 6, 6, 6)


	'INSTRUCTION: Copy & paste the code below to where your "dlgClasses.Container" is being built!

	Dim swtclassoninit As VMCheckBox = vm.NewSwitch(Me, False, "swtclassoninit", "classoninit", "OnSignature", "Yes", "No", False, 0)
	swtclassoninit.SetFieldType("string")
	swtclassoninit.SetValue("Yes")
	swtclassoninit.SetDense(True)
	swtclassoninit.SetVisible(True)
	dlgClasses.Container.AddControl(swtclassoninit.CheckBox, swtclassoninit.tostring, 8, 2, 0, 0, 0, 0, 12, 6, 6, 6)
	vm.AddDialog(dlgClasses)
End Sub

'add code to save the Classe
Sub btnOkClasses_click(e As BANanoEvent)
	'create/update record to table
	'get the record to create/update
	Dim Record As Map = dlgClasses.Container.GetData
	'validate the record
	Dim bValid As Boolean = vm.Validate(Record, dlgClasses.Container.Required)
	'if invalid exit create/update
	If bValid = False Then
		Dim strError As String = vue.GetError
		vm.ShowSnackBarError(strError)
		Return
	End If
	'resultset variable
	Dim rsClasses As BANanoMySQLE
	'check mode
	Select Case Mode
		Case "A"
			'initialize table for insert
			rsClasses.Initialize("bananocvc", "classes", "classid", "classid")
			'define schema for record
			rsClasses.SchemaFromDesign(dlgClasses.Container)
			'insert a record
			rsClasses.Insert1(Record)
			'generate & run command to insert record
			rsClasses.JSON = BANano.CallInlinePHPWait(rsClasses.MethodName, rsClasses.Build)
			rsClasses.FromJSON
		Case "E"
			'read record id
			Dim RecID As String = Record.Get("classid")
			'initialize table for edit
			rsClasses.Initialize("bananocvc", "classes", "classid", "classid")
			'define schema for record
			rsClasses.SchemaFromDesign(dlgClasses.Container)
			'update a record
			rsClasses.Update1(Record, RecID)
			'generate & run command to update record
			rsClasses.JSON = BANano.CallInlinePHPWait(rsClasses.MethodName, rsClasses.Build)
			rsClasses.FromJSON
	End Select
	'hide the modal
	dlgClasses.Hide
	'execute code to refresh listing for Classes
	vm.CallMethod("SelectAll_Classes")
End Sub

'add code to cancel the dialog for Classe
Sub btnCancelClasses_click(e As BANanoEvent)
	'hide the modal
	dlgClasses.Hide
End Sub

'classes Clone action
Sub dtclasses_clone(item As Map)
	'get the key
	Dim RecID As String = item.Get("classid")
	If RecID = "" Then Return
	'set mode to A-dd
	Mode = "A"
	'read existing record from database
	Dim rsClasses As BANanoMySQLE
	'initialize table for table creation
	rsClasses.Initialize("bananocvc", "classes", "classid", "classid")
	'define schema for record
	rsClasses.SchemaFromDesign(dlgClasses.Container)
	'generate & run command to read record
	rsClasses.Read(RecID)
	rsClasses.JSON = BANano.CallInlinePHPWait(rsClasses.MethodName, rsClasses.Build)
	rsClasses.FromJSON
	'was the read successful?
	If rsClasses.Result.Size = 0 Then Return
	'the record as found!
	Dim Record As Map = rsClasses.Result.Get(0)
	'nullify key
	Record.put("classid", Null)
	'Update the dialog details
	dlgClasses.SetTitle("New Class")
	'show the modal
	dlgClasses.Show
	'update the state, this updates the v-model(s) for each input control
	vm.SetState(Record)
End Sub

'delete all records
Sub DeleteAll_Events
	Dim rsEvents As BANanoMySQLE
	'initialize table for table creation
	rsEvents.Initialize("bananocvc", "events", "eventid", "eventid")
	rsEvents.DeleteAll
	rsEvents.JSON = BANano.CallInlinePHPWait(rsEvents.MethodName, rsEvents.Build)
	rsEvents.FromJSON
	'execute code to refresh listing for Events
	vm.CallMethod("SelectAll_Events")
End Sub

'delete single record
Sub DeleteRecord_Events(RecordID As String)
	Dim rsEvents As BANanoMySQLE
	'initialize table for deletion
	rsEvents.Initialize("bananocvc", "events", "eventid", "eventid")
	'define schema for record
	rsEvents.SchemaFromDesign(dlgEvents.Container)
	'generate & run command to delete single record
	rsEvents.Delete(RecordID)
	rsEvents.JSON = BANano.CallInlinePHPWait(rsEvents.MethodName, rsEvents.Build)
	rsEvents.FromJSON
	'execute code to refresh listing for Events
	vm.CallMethod("SelectAll_Events")
End Sub

'select all records
Sub SelectAll_Events
	Dim rsEvents As BANanoMySQLE
	'initialize table for table creation
	rsEvents.Initialize("bananocvc", "events", "eventid", "eventid")
	Dim aw As Map = CreateMap()
	aw.put("componentid", scomponentid)
	rsEvents.SelectWhere("events", Array("*"), aw, Array("="), Array("eventname"))
	rsEvents.JSON = BANano.CallInlinePHPWait(rsEvents.MethodName, rsEvents.Build)
	rsEvents.FromJSON
	'save records to state
	vm.SetData("events", rsEvents.Result)
	'update the data table records
	dtevents.SetDataSource(rsEvents.Result)
	Dim aCount As Int = rsEvents.result.Size
	vm.SetBadgeContent("tabEvents", aCount)
End Sub

'events Edit action
Sub dtevents_edit(item As Map)
	'get the key
	Dim RecID As String = item.Get("eventid")
	If RecID = "" Then Return
	'set mode to E-dit
	Mode = "E"
	'read record from database
	Dim rsEvents As BANanoMySQLE
	'initialize table for table creation
	rsEvents.Initialize("bananocvc", "events", "eventid", "eventid")
	'define schema for record
	rsEvents.SchemaFromDesign(dlgEvents.Container)
	'generate & run command to read record
	rsEvents.Read(RecID)
	rsEvents.JSON = BANano.CallInlinePHPWait(rsEvents.MethodName, rsEvents.Build)
	rsEvents.FromJSON
	'was the read successful?
	If rsEvents.Result.Size = 0 Then Return
	'the record as found!
	Dim Record As Map = rsEvents.result.get(0)
	'Update the dialog details
	dlgEvents.SetTitle("Edit Events")
	'show the modal
	dlgEvents.Show
	'update the state, this updates the v-model(s) for each input control
	vm.SetState(Record)
End Sub


'events Delete action
Sub dtevents_delete(item As Map)
	'get the key
	Dim RecID As String = item.Get("eventid")
	If RecID = "" Then Return
	'save the id to delete
	vm.SetData("eventseventid", RecID)
	'show confirm dialog
	Dim seventid As String = item.getdefault("eventid","")
	vm.ShowConfirm("delete_events", "Confirm Delete: " & seventid, _
"Are you sure that you want to delete this Events. You will not be able to undo your actions. Continue?","Ok","Cancel")
End Sub


'add a new Events
Sub AddEvents
	'set mode to A-add
	Mode = "A"
	'update the title
	dlgEvents.SetTitle("New Events")
	'show dialog
	dlgEvents.Show
	vm.setdata("projectid", sprojectid)
	vm.setdata("componentid", scomponentid)
	vm.SetFocus("txteventname")
End Sub


'when add new is clicked
Sub btnNewEvents_click(e As BANanoEvent)
	AddEvents
End Sub

'create dialog
Sub CreateDialog_Events
	dlgEvents = vm.CreateDialog("dlgEvents", Me)
	dlgEvents.SetTitle("Events")
	dlgEvents.SetOk("btnOkEvents","Save")
	dlgEvents.SetCancel("btnCancelEvents","Cancel")
	dlgEvents.Setwidth("700px")
	dlgEvents.Setpersistent(True)
	'*** Add code to create components below this line!
	
	'INSTRUCTION: Copy & paste the code below to where your "dlgEvents.Container" is being built!

	Dim txteventid As VMTextField = vm.NewTextField(Me, False, "txteventid", "eventid", "Eventid", "", False, "", 11, "", "", 0)
	txteventid.SetFieldType("int")
	txteventid.SetVisible(False)
	dlgEvents.Container.AddControl(txteventid.textfield, txteventid.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgEvents.Container" is being built!

	Dim txtprojectid As VMTextField = vm.NewTextField(Me, False, "txtprojectid", "projectid", "Projectid", "", False, "", 11, "", "", 0)
	txtprojectid.SetFieldType("int")
	txtprojectid.SetVisible(False)
	dlgEvents.Container.AddControl(txtprojectid.textfield, txtprojectid.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgEvents.Container" is being built!

	Dim txtcomponentid As VMTextField = vm.NewTextField(Me, False, "txtcomponentid", "componentid", "Componentid", "", False, "", 11, "", "", 0)
	txtcomponentid.SetFieldType("int")
	txtcomponentid.SetVisible(False)
	dlgEvents.Container.AddControl(txtcomponentid.textfield, txtcomponentid.tostring, 1, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgEvents.Container" is being built!

	Dim txteventname As VMTextField = vm.NewTextField(Me, False, "txteventname", "eventname", "Event Name", "", True, "", 0, "", "The event name is required!", 0)
	txteventname.SetFieldType("string")
	txteventname.SetAutoFocus(True)
	txteventname.SetVisible(True)
	dlgEvents.Container.AddControl(txteventname.textfield, txteventname.tostring, 2, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgEvents.Container" is being built!

	Dim txteventarguments As VMTextField = vm.NewTextField(Me, False, "txteventarguments", "eventarguments", "Arguments", "", False, "", 255, "", "", 0)
	txteventarguments.SetFieldType("string")
	txteventarguments.SetVisible(True)
	dlgEvents.Container.AddControl(txteventarguments.textfield, txteventarguments.tostring, 3, 1, 0, 0, 0, 0, 12, 12, 12, 12)


	'INSTRUCTION: Copy & paste the code below to where your "dlgEvents.Container" is being built!

	Dim swteventactive As VMCheckBox = vm.NewSwitch(Me, False, "swteventactive", "eventactive", "Active", "Yes", "No", False, 0)
	swteventactive.SetFieldType("string")
	swteventactive.SetVisible(True)
	dlgEvents.Container.AddControl(swteventactive.CheckBox, swteventactive.tostring, 4, 1, 0, 0, 0, 0, 12, 6, 6, 6)

	vm.AddDialog(dlgEvents)
End Sub

'add code to save the Events
Sub btnOkEvents_click(e As BANanoEvent)
	'create/update record to table
	'get the record to create/update
	Dim Record As Map = dlgEvents.Container.GetData
	'validate the record
	Dim bValid As Boolean = vm.Validate(Record, dlgEvents.Container.Required)
	'if invalid exit create/update
	If bValid = False Then
		Dim strError As String = vue.GetError
		vm.ShowSnackBarError(strError)
		Return
	End If
	'resultset variable
	Dim rsEvents As BANanoMySQLE
	'check mode
	Select Case Mode
		Case "A"
			'initialize table for insert
			rsEvents.Initialize("bananocvc", "events", "eventid", "eventid")
			'define schema for record
			rsEvents.SchemaFromDesign(dlgEvents.Container)
			'insert a record
			rsEvents.Insert1(Record)
			'generate & run command to insert record
			rsEvents.JSON = BANano.CallInlinePHPWait(rsEvents.MethodName, rsEvents.Build)
			rsEvents.FromJSON
		Case "E"
			'read record id
			Dim RecID As String = Record.Get("eventid")
			'initialize table for edit
			rsEvents.Initialize("bananocvc", "events", "eventid", "eventid")
			'define schema for record
			rsEvents.SchemaFromDesign(dlgEvents.Container)
			'update a record
			rsEvents.Update1(Record, RecID)
			'generate & run command to update record
			rsEvents.JSON = BANano.CallInlinePHPWait(rsEvents.MethodName, rsEvents.Build)
			rsEvents.FromJSON
	End Select
	'hide the modal
	dlgEvents.Hide
	'execute code to refresh listing for Events
	vm.CallMethod("SelectAll_Events")
End Sub

'add code to cancel the dialog for Events
Sub btnCancelEvents_click(e As BANanoEvent)
	'hide the modal
	dlgEvents.Hide
End Sub
