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
	'import bootstrap vue web types
	vm.AddFileSelect(Me, "bvwebtypes")
	vm.AddFileSelect(Me, "bvtags")
	vm.AddFileSelect(Me, "bvattributes")
	
End Sub

'bootstrap vue attributes
Sub bvattributes_change(e As BANanoEvent)
	'get the file contents
	Dim res As Map
	Dim err As Map
	Dim readPromise As BANanoPromise = BANanoShared.GetFileAsText(e)
	readPromise.Then(res)
	Dim fc As String = res.get("result")
	UploadBVAttributes(fc)
	readPromise.Else(err)
	readPromise.end
	vm.NullifyFileSelect("bvattributes")
End Sub

'upload bv attributes
Sub UploadBVAttributes(fc As String)
	Dim components As Map = vm.GetData("components")
	
	If BANano.IsNull(components) Or BANano.IsUndefined(components) Then
		vm.ShowSnackBarError("The components have not been imported yet!")
		Return
	End If
	'
	Dim wbm As Map = BANano.fromjson(fc)
	For Each k As String In wbm.Keys
		Dim attrm As Map = wbm.Get(k)
		Dim stype As String = attrm.get("type")
		'
		Dim compName As String = vm.MvField(k,1,"/")
		Dim attrName As String = vm.mvfield(k,2,"/")
		'
		Dim bComp As String = vm.beautifyname(compName)
		Dim aComp As String = vm.BeautifyRest(attrName)
		
		'does the component exist		
		If components.ContainsKey(bComp) Then
			'get the component
			Dim oldcomp As Map = components.get(bComp)
			'update the tab
			oldcomp.put("tag", compName)
			'get the attributes
			Dim oldattributes As List = oldcomp.get("attributes")
			For Each oldattr As Map In oldattributes
				Dim sname As String = oldattr.get("name")
				If sname = aComp Then 
					oldattr.put("tag", attrName)
					stype = CleanType(stype)
					oldattr.put("type", stype)
				End If
			Next
			oldcomp.Put("attributes", oldattributes)
			components.put(bComp, oldcomp)
		Else
			Log($"${compName} NOT FOUND!"$)
		End If
	Next
	vm.setdata("components", components)	
	vm.ShowSnackBarSuccess($"${components.size} components processed!"$)
	'upload to system
	vm.Showloading
	'read the project details
	Dim mproject As Map = vm.GetData("project")
	'
	Dim cprojectid As String = mproject.getdefault("projectid","")
	'delete everything for project
	Dim rsComponents As BANanoMySQLE
	rsComponents.Initialize("bananocvc", "components", "projectid", "projectid")
	rsComponents.SchemaAddInt(Array("projectid"))
	rsComponents.Delete(cprojectid)
	rsComponents.JSON = BANano.CallInlinePHPWait(rsComponents.MethodName, rsComponents.Build)
	rsComponents.FromJSON
	'delete attributes
	Dim rsAttributes As BANanoMySQLE
	rsAttributes.Initialize("bananocvc", "attributes", "projectid", "projectid")
	rsAttributes.SchemaAddInt(Array("projectid"))
	rsAttributes.Delete(cprojectid)
	rsAttributes.JSON = BANano.CallInlinePHPWait(rsAttributes.MethodName, rsAttributes.Build)
	rsAttributes.FromJSON
	'delete styles
	Dim rsStyles As BANanoMySQLE
	rsStyles.Initialize("bananocvc", "styles", "projectid", "projectid")
	rsStyles.SchemaAddInt(Array("projectid"))
	rsStyles.Delete(cprojectid)
	rsStyles.JSON = BANano.CallInlinePHPWait(rsStyles.MethodName, rsStyles.Build)
	rsStyles.FromJSON
	'delete classes
	Dim rsClasses As BANanoMySQLE
	rsClasses.Initialize("bananocvc", "classes", "projectid", "projectid")
	rsClasses.SchemaAddInt(Array("projectid"))
	rsClasses.Delete(cprojectid)
	rsClasses.JSON = BANano.CallInlinePHPWait(rsClasses.MethodName, rsClasses.Build)
	rsClasses.FromJSON
	'delete events
	Dim rsEvents As BANanoMySQLE
	rsEvents.Initialize("bananocvc", "events", "projectid", "projectid")
	rsEvents.SchemaAddInt(Array("projectid"))
	rsEvents.Delete(cprojectid)
	rsEvents.JSON = BANano.CallInlinePHPWait(rsEvents.MethodName, rsEvents.Build)
	rsEvents.FromJSON
	'
	'add the components
	For Each k As String In components.keys
		Dim comp As Map = components.get(k)
		Dim sname As String = comp.get("name")
		Dim stag As String = comp.get("tag")
		'
		Dim rsComponent As BANanoMySQLE
		rsComponent.Initialize("bananocvc", "components", "componentid", "componentid")
		rsComponent.SchemaAddInt(Array("projectid"))
		Dim record As Map = CreateMap()
		record.put("projectid", cprojectid)
		record.put("componenttag",stag)
		record.put("componentdescription", sname)
		rsComponent.Insert1(record)
		rsComponent.JSON = BANano.CallInlinePHPWait(rsComponent.MethodName, rsComponent.Build)
		rsComponent.FromJSON
	Next
	'select all components for project
	Dim rsComponentsU As BANanoMySQLE
	rsComponentsU.Initialize("bananocvc", "components", "componentid", "componentid")
	rsComponentsU.SchemaAddInt(Array("componentid","projectid"))
	Dim cw As Map = CreateMap()
	cw.put("projectid", cprojectid)
	rsComponentsU.SelectWhere("components", Array("*"), cw, Array("="), Array("componentdescription"))
	rsComponentsU.JSON = BANano.CallInlinePHPWait(rsComponentsU.MethodName, rsComponentsU.Build)
	rsComponentsU.FromJSON
	Dim Result As List = rsComponentsU.Result
	For Each compU As Map In Result
		Dim sname As String = compU.Get("componentdescription")
		Dim stag As String = compU.Get("componenttag")
		Dim scomponentid  As String = compU.get("componentid")
		
		'get the component from the previouslt saved list
		Dim xcomponent As Map = components.get(sname)
		Dim attributesL As List = xcomponent.get("attributes")
		For Each attrm As Map In attributesL
			Dim sdefault As String = attrm.get("default")
			Dim sdescription As String = attrm.Get("description")
			sdescription = CleanDescription(sdescription)
			Dim stag As String = attrm.get("tag")
			Dim stype As String = attrm.get("type")
			stype = BANanoShared.BeautifyName(stype)
			'
			Dim na As Map = CreateMap()
			na.put("attrname", stag)
			na.Put("projectid", cprojectid)
			na.put("componentid", scomponentid)
			na.put("defaultvalue", sdefault)
			na.put("attrtype", stype)
			na.put("attrdescription", sdescription)
			na.put("attrhasset", "Yes")
			na.put("attrhasget", "Yes")
			na.put("attroptions", "")
			na.put("attrmin", "")
			na.put("attrmax","")
			na.put("attronsub", "No")
			na.put("attroninit", "No")
			na.put("attrdesigner", "No")
			na.put("attrexplode", "No")
			Select Case stype
			Case "Boolean", "String", "boolean", "string"
				na.put("attrdesigner", "Yes")
			End Select
			'add to database
			Dim rsA As BANanoMySQLE
			rsA.Initialize("bananocvc", "attributes", "attrid", "attrid")
			rsA.SchemaAddInt(Array("attrid","projectid","componentid"))
			rsA.Insert1(na)
			rsA.JSON = BANano.CallInlinePHPWait(rsA.MethodName, rsA.Build)
			rsA.FromJSON
		Next
		'process events
		Dim eventsL As List = xcomponent.get("events")
		For Each eventM As Map In eventsL
			Dim ename As String = eventM.get("name")
			Dim em As Map = CreateMap()
			em.put("eventname", ename)
			em.put("eventarguments", "")
			em.put("eventactive", "Yes")
			em.put("projectid", cprojectid)
			em.put("componentid", scomponentid)
			'
			Dim sbxE As StringBuilder
			sbxE.Initialize
			'
			If eventM.containskey("arguments") Then
				Dim eventsL As List = eventM.get("arguments")
				For Each emm As Map In eventsL
					Dim eargument As String = emm.get("argument")
					Dim etype As String = emm.get("type")
					etype = CleanArgument(etype)
					'					
					sbxE.append($"${eargument} As ${etype},"$)
				Next
			End If
			Dim sbyE As String = sbxE.tostring
			sbyE = vue.remdelim(sbyE, ",")
			em.put("eventarguments", sbyE)
			'
			'add to database
			Dim rsE As BANanoMySQLE
			rsE.Initialize("bananocvc", "events", "eventid", "eventid")
			rsE.SchemaAddInt(Array("eventid","projectid","componentid"))
			rsE.Insert1(em)
			rsE.JSON = BANano.CallInlinePHPWait(rsE.MethodName, rsE.Build)
			rsE.FromJSON
		Next
		'process styles
		Dim stylesL As List = xcomponent.get("styles")
		For Each mstyle As Map In stylesL
			mstyle.put("projectid", cprojectid)
			mstyle.put("componentid", scomponentid)
			'
			'add to database
			Dim rsS As BANanoMySQLE
			rsS.Initialize("bananocvc", "styles", "styleid", "styleid")
			rsS.SchemaAddInt(Array("styleid","projectid","componentid"))
			rsS.Insert1(mstyle)
			rsS.JSON = BANano.CallInlinePHPWait(rsS.MethodName, rsS.Build)
			rsS.FromJSON
		Next
	Next
	
	vm.HideLoading
	vm.CallMethod("SelectAll_Components")
End Sub

'bootstrap vue tags
Sub bvtags_change(e As BANanoEvent)
	'get the file contents
	Dim res As Map
	Dim err As Map
	Dim readPromise As BANanoPromise = BANanoShared.GetFileAsText(e)
	readPromise.Then(res)
	Dim fc As String = res.get("result")
	UploadTags(fc)
	readPromise.Else(err)
	readPromise.end
	vm.NullifyFileSelect("bvtags")
End Sub

Sub UploadTags(fc As String)
	'get the saved tags
	Dim components As Map = vm.GetData("components")
	
	If BANano.IsNull(components) Or BANano.IsUndefined(components) Then
		vm.ShowSnackBarError("The components have not been imported yet!")
		Return 
	End If
	'
	vm.showloading
	
	Dim wbm As Map = BANano.fromjson(fc)
	For Each k As String In wbm.keys
		'brautify the name
		Dim cName As String = vm.BeautifyName(k)
		'only process those that are not icons
		If k.startswith("b-icon-") = False Then
			'get the component from the list
			If components.ContainsKey(cName) Then
				'get the component
				Dim oldcomp As Map = components.get(cName)
				'update the tab
				oldcomp.put("tag", k)
				'get the attributes
				Dim oldattributes As List = oldcomp.get("attributes")
				Dim oldattributesk As Map = CreateMap()
				For Each oldattr As Map In oldattributes
					Dim sname As String = oldattr.get("name")
					oldattributesk.put(sname, sname)
				Next
				'
				Dim comp As Map = wbm.Get(k)
				Dim attributes As List = comp.Get("attributes")
				For Each colattributes As String In attributes
					Dim beaAttr As String = vm.BeautifyRest(colattributes)
					'check if attributes match
					If oldattributesk.containskey(beaAttr) = False Then
						Log($"Missing attribute: ${cName}.${colattributes}"$)
					End If
				Next
			End If
		End If
	Next
	'save the components
	vm.HideLoading
	vm.SetData("components", components)
	vm.ShowSnackBarSuccess($"${components.size} components processed!"$)
	Log(components)
End Sub

'bootstrap vue web types
Sub bvwebtypes_change(e As BANanoEvent)
	'get the file contents
	Dim res As Map
	Dim err As Map
	Dim readPromise As BANanoPromise = BANanoShared.GetFileAsText(e)
	readPromise.Then(res)
		Dim fc As String = res.get("result")
		UploadWebTypes(fc)
	readPromise.Else(err)
	readPromise.end
	'upload the file to the server
	
	'get the file name
	'Dim sFileName As String = BANanoShared.GetUploadFileName(e)
	'start the import
	'Dim Rslt As Map
	'Dim uploadPromise As BANanoPromise = BANanoShared.UploadFile(e)
	'uploadPromise.Then(Rslt)
	'	'get the result of the upload
	'	Dim filePath As String = BANanoShared.GetUploadResult(sFileName, Rslt)
	'	Log(filePath)
	'uploadPromise.End
	vm.NullifyFileSelect("bvwebtypes")
End Sub

'upload the web types file
Sub UploadWebTypes(fc As String)
	Dim components As Map = CreateMap()
	vm.ShowLoading
	'
	Dim wbm As Map = BANano.fromjson(fc)
		
	Dim contributions As Map = wbm.get("contributions")
	Dim html As Map = contributions.get("html")
	Dim tags As List = html.Get("tags")
	'
	For Each coltags As Map In tags
		Dim colname As String = coltags.GetDefault("name", "")
		Dim coldescription As String = coltags.GetDefault("description","")
		'
		colname = CleanDescription(colname)
		If colname = "" Then Continue
		
		'exclude icons
		If colname.startswith("BIcon") Then Continue
			
		'component
		Dim comp As Map = CreateMap()
		comp.put("name", colname)
		comp.put("description", coldescription)
		'
		Dim compattrs As List = vm.newlist
		'		
		If coltags.ContainsKey("attributes") Then
			'process attributes
			Dim cattributes As List = coltags.Get("attributes")
			'
			For Each colattributes As Map In cattributes
				Dim adefault As String = colattributes.GetDefault("default","")
				Dim aname As String = colattributes.GetDefault("name","")
				Dim adescription As String = colattributes.GetDefault("description","")
				Dim atype As String = colattributes.GetDefault("type","")
				adescription = CleanDescription(adescription)
								'
				adefault = adefault.replace(QUOTE,"")
				adefault = adefault.replace("null", "")
				adefault = adefault.replace("undefined", "")
				adefault = adefault.replace("'","")
				If adefault.startswith("[") Then adefault = ""
				If adefault.startswith("{") Then adefault = ""
				If adefault.startswith("(") Then adefault = ""
				'
				If atype = "" Then
					If colattributes.ContainsKey("value") Then
						Dim avalue As Map = colattributes.Get("value")
						If avalue.containskey("type") Then 
							Dim otype As Object = avalue.get("type")
							Dim stype As String = GetType(otype)
							Select Case stype
							Case "string"	
								atype = avalue.GetDefault("type","")
							Case Else
								atype = vue.join("|", otype)
							End Select
						End If
					End If
				End If
				'
				If aname <> "" Then
					'
					If aname.EqualsIgnoreCase("id") Then Continue
					'
					Dim mattr As Map = CreateMap()
					mattr.put("default", adefault)
					mattr.Put("name", aname)
					mattr.put("description", adescription)
					atype = CleanType(atype)
					mattr.put("type", atype)
					'
					Select Case aname
					Case "color", "text-color","background-color"
						mattr.Put("attroptions","amber|black|blue|blue-grey|brown|cyan|deep-orange|deep-purple|green|grey|indigo|light-blue|light-green|lime|orange|pink|purple|red|teal|transparent|white|yellow|primary|secondary|accent|error|info|success|warning|none")
					Case "transition"
						mattr.put("attroptions", "slide-x-transition|slide-x-reverse-transition|slide-y-transition|slide-y-reverse-transition|scroll-x-transition|scroll-x-reverse-transition|scroll-y-transition|scroll-y-reverse-transition|scale-transition|fade-transition|fab-transition|none")
					Case "target"
						mattr.put("attroptions", "_blank|_self|_parent|_top|none")
					Case "type"
						If colname.EqualsIgnoreCase("v-alert") Or colname.EqualsIgnoreCase("VAlert") Then
							mattr.put("attroptions", "success|info|warning|error|none")
						End If
					Case "border"
						If colname.EqualsIgnoreCase("v-alert") Or colname.EqualsIgnoreCase("VAlert") Then
							mattr.put("attroptions", "top|right|bottom|left|none")
						End If
					End Select
					'add attribute to list
					compattrs.add(mattr)
				End If
			Next
		End If
		'
		'add vue attributes
		Dim vueattributes As List = vue.newlist
		vueattributes.AddAll(Array("key", "v-html", "v-text", "v-model", "ref", "v-if", "v-else", "v-show", _
		"v-for", "v-else-if", "v-bind:class","v-bind:style","parent-id","v-on"))
		For Each attrx As String In vueattributes
			'the key should be the component.attribute
			Dim mattr As Map = CreateMap()
			mattr.put("default", "")
			mattr.Put("name", attrx)
			mattr.put("description", attrx)
			mattr.put("type", "string")
			mattr.put("tag", attrx)
			compattrs.add(mattr)
		Next
		
		'component, add attributes
		comp.put("attributes", compattrs)
		'
		Dim compEvents As List = vm.newlist
		'process events
		If coltags.ContainsKey("events") Then
			'process events
			Dim events As List = coltags.Get("events")
			
			For Each colevents As Map In events
				'get the event
				Dim ename As String = colevents.GetDefault("name","")
				Dim edescription As String = colevents.GetDefault("description","")
				'
				ename = CleanDescription(ename)
				If ename = "" Then Continue
				'
				Dim event As Map = CreateMap()
				event.put("name", ename)
				event.put("description", edescription)
				'
				Dim eventl As List = vm.newlist
				'arguemets
				If colevents.containskey("arguments") Then
					Dim arguments As List = colevents.Get("arguments")
					'
					For Each colarguments As Map In arguments
						Dim colargumentsname As String = colarguments.GetDefault("name","")
						Dim colargumentsdescription As String = colevents.GetDefault("description","")
						'
						colargumentsname = CleanDescription(colargumentsname)
						If colargumentsname = "" Then Continue
						'
						'save the event
						Dim eventt As Map = CreateMap()
						eventt.put("argument", colargumentsname)
						eventt.put("description",colargumentsdescription)
						'
						If colarguments.containskey("type") Then
							Dim colargumentstype As String = colarguments.Get("type")
							colargumentstype = CleanArgument(colargumentstype)
							eventt.put("type", colargumentstype)
						Else
							eventt.put("type", "Object")
						End If
						
						eventl.add(eventt)
					Next
					event.put("arguments", eventl)
				End If
				compEvents.Add(event)
			Next
		End If
		comp.put("events", compEvents)
		'add style
		Dim mstyles As List = BANanoShared.NewList
		mstyles.AddAll(Array("border-color","border-style","border-width","border-radius","margin-top","margin-right","margin-bottom"))
		mstyles.AddAll(Array("margin-left","padding-top","padding-right","padding-bottom","padding-left"))
		'
		Dim compStyles As List = BANanoShared.NewList
		'
		For Each mse As String In mstyles
			Dim mstyle As Map = CreateMap()
			mstyle.put("stylename", mse)
			mstyle.put("styletype","String")
			mstyle.put("stylehasset", "Yes")
			mstyle.put("stylehasget", "Yes")
			mstyle.put("styleonsub", "No")
			mstyle.put("styleoninit", "No")
			mstyle.put("styledesigner", "Yes")
			mstyle.put("defaultvalue", "")
			mstyle.put("styleoptions", "")
			mstyle.Put("styledescription","")
			
			Select Case mse
			Case "border-style"
				mstyle.put("styleoptions", "dashed|dotted|double|groove|hidden|inset|none|outset|ridge|solid")
			Case "border-color"
				mstyle.put("styleoptions", "amber|black|blue|blue-grey|brown|cyan|deep-orange|deep-purple|green|grey|indigo|light-blue|light-green|lime|orange|pink|purple|red|teal|transparent|white|yellow|primary|secondary|accent|error|info|success|warning|none")
			End Select			
			compStyles.Add(mstyle)
		Next
		comp.put("styles", compStyles)
		'save them as map
		components.put(colname, comp)
	Next
	'
	vm.hideloading
	'save the components
	vm.SetData("components", components)
	vm.ShowSnackBarSuccess($"${components.size} components processed!"$)
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
	'delete events
	Dim rsEvents As BANanoMySQLE
	rsEvents.Initialize("bananocvc", "events", "componentid", "componentid")
	rsEvents.SchemaAddInt(Array("componentid"))
	rsEvents.Delete(RecordID)
	rsEvents.JSON = BANano.CallInlinePHPWait(rsEvents.MethodName, rsEvents.Build)
	rsEvents.FromJSON
	
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
	rsComponents.SchemaAddInt(Array("projectid"))
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


Sub menuImportItems_click(e As BANanoEvent)
	Dim menuID As String = vm.getidfromevent(e)
	Select Case menuID
	Case "bootstrapvuewebtypes"
		'file select
		vm.ShowFileSelect("bvwebtypes")
		'
	Case "bootstrapvuetags"
		vm.ShowFileSelect("bvtags")
	
	Case "bootstrapvueattributes"
		vm.ShowFileSelect("bvattributes")
	End Select
End Sub

Sub CreateDataTable_components
	dtcomponents = vm.CreateDataTable("dtcomponents", "componentid", Me)
	dtcomponents.SetTitle("Components")
	dtcomponents.SetSearchbox(True)
	dtcomponents.AddDivider
	dtcomponents.SetAddNew("btnNewComponent", "mdi-plus", "Add a new component")
	dtcomponents.AddDivider
	'menu to import bootstrap
	Dim menuImport As VMMenu
	menuImport.Initialize(vue, "menuImport", Me)
	menuImport.SetIcon("mdi-database-plus")
	menuImport.AddItem("bootstrapvuewebtypes","","","WebTypes.JSON","","")
	menuImport.AddItem("bootstrapvuetags","","","Tags.JSON","","")
	menuImport.AddItem("bootstrapvueattributes","","","Attributes.JSON","","")
	'
	dtcomponents.AddMenu(menuImport)
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

'clean the attribute type
Sub CleanType(cType As String) As String
	cType = cType.replace("[","")
	cType = cType.replace("}","")
	cType = cType.replace("{","")
	cType = cType.replace("]","")
	cType = cType.replace("Date", "string")
	cType = cType.replace("date", "string")
	cType = cType.replace("HTMLElement", "string")
	cType = cType.replace("File", "string")
	cType = cType.replace("SVGElement", "string")
	cType = cType.replace("RegExp", "string")
	cType = cType.replace("function", "string")
	cType = cType.replace("object", "string")
	cType = cType.replace("number", "string")
	cType = cType.replace("any", "string")
	cType = cType.replace("dataoptions", "Object")
	cType = cType.replace("tableheader", "Object")
	cType = vue.MvDistinct("|", cType)
	cType = cType.replace("array|string", "string")
	cType = cType.replace("boolean|array", "boolean")
	cType = cType.replace("boolean|string", "string")
	cType = cType.replace("string|array", "string")
	cType = cType.replace("string|boolean","string")
	cType = cType.replace("array", "List")
	If cType = "" Then cType = "string"
	Return cType	
End Sub

Sub CleanArgument(etype As String) As String
	etype = etype.tolowercase
	If etype.Startswith("boolean") Then etype = "Boolean"
	If etype.EndsWith("event") Then etype = "BANanoEvent"
	If etype.startswith("file") Then etype = "List"
	If etype.Startswith("number") Then etype = "Int"
	If etype.startswith("any") Then etype = "Object"
	If etype.startswith("array") Then etype = "List"
	If etype.startswith("object") Then etype = "Object"
	If etype.startswith("string") Then etype = "String"
	If etype.startswith("void") Then etype = "Object"
	If etype.startswith("{") Then etype = "Object"
	Return etype
End Sub

Sub CleanDescription(sdesc As String) As String
	sdesc = sdesc.replace(QUOTE,"")
	sdesc = sdesc.replace("null", "")
	sdesc = sdesc.replace("undefined", "")
	sdesc = sdesc.replace("'","")
	sdesc = sdesc.replace("[","")
	sdesc = sdesc.replace("]","")
	sdesc = sdesc.replace("{","")
	sdesc = sdesc.replace("}","")
	sdesc = sdesc.replace(")","")
	sdesc = sdesc.replace("(","")
	Return sdesc
End Sub