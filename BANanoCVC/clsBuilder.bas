B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.45
@EndOfDesignText@
Sub Class_Globals
	Private attributes As List
	Private compName As String
	Private vm As BANanoVM
	Private styles As List
	Private classes As List
	Private events As List
	Private tagName As String
	Public projectvue As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(v As BANanoVM, sTagName As String, scompName As String, attrs As List, styls As List, cls As List, evnts As List)
	attributes = attrs
	compName = scompName
	styles = styls
	classes = cls
	events = evnts
	tagName = sTagName.tolowercase
	vm = v
End Sub

Sub CreateCustomView As String
	'complete custom view file
	Dim CV As StringBuilder
	CV.Initialize
	'
	'event handling
	Dim EC As StringBuilder
	EC.Initialize
	'
	'variable declarations
	Dim VD As StringBuilder
	VD.initialize
	'
	'designer properties
	Dim DP As StringBuilder
	DP.initialize
	'
	'gets and sets
	Dim GS As StringBuilder
	GS.initialize
	'
	'read desiner properties
	Dim RD As StringBuilder
	RD.initialize
	
	'all attributes
	Dim AA As StringBuilder
	AA.initialize
	'
	'all events
	Dim EV As StringBuilder
	EV.Initialize 
	
	AddCode(CV, "B4J=true")
	AddCode(CV, "Group=Default Group")
	AddCode(CV, "ModulesStructureVersion=1")
	AddCode(CV, "Type=Class")
	AddCode(CV, "Version=7")
	AddCode(CV, "@EndOfDesignText@")
	AddCode(CV, $"#IgnoreWarnings:12"$)
	AddComment(CV, $"Created with BANano Custom View Creator ${Main.version} by TheMash"$)
	AddComment(CV, $"https://github.com/Mashiane/BANano-Custom-View-Creator"$)
	AddComment(CV, "Custom BANano View class")
	AddNewLine(CV)
	'add the events
	For Each event As Map In events
		Dim eventname As String = event.get("eventname")
		eventname = eventname.trim
		Dim eventarguments As String = event.Get("eventarguments")
		Dim eventactive As String = event.get("eventactive")
		eventarguments = eventarguments.trim
		If eventactive = "No" Then Continue
		If eventname = "undefined" Then Continue
		'
		'add code to handle the event
		If projectvue = "Yes" Then
			Dim ename As String = BANanoShared.BeautifyName(eventname)
			Dim xname As String = ename
			If ename = "" Then Continue
			
			AddCode(CV, $"#Event: ${ename} (${eventarguments})"$)
			'
			AddComment(EC, $"This activates ${ename} the event exists on the module"$)
			AddCode(EC, $"SetOn${ename}"$)
			'
			AddComment(EV, "set on " & ename & " event, updates the master events records")
			AddCode(EV, $"Sub SetOn${ename}()"$)
			AddCode(EV, $"Dim sName As String = ~"~{mEventName}_${ename}"~"$)
			AddCode(EV, $"sName = sName.tolowercase"$)
			AddCode(EV, $"If SubExists(mCallBack, sName) = False Then Return"$)			
			AddCode(EV, $"If BANano.IsUndefined(eOn${ename}) Or BANano.IsNull(eOn${ename}) Then eOn${ename} = """$)
			AddCode(EV, $"Dim sCode As String = ~"~{sName}(~{eOn${ename}})"~"$)
			AddCode(EV, $"AddAttr("v-on:${eventname}", sCode)"$)
			If eventarguments <> "" Then
				AddComment(EV, "arguments for the event")
				AddCode(EV, $"Dim ${eventarguments} 'ignore"$)
				Dim xarguments As String = GetVariablesFromArguments(eventarguments)
				AddCode(EV, $"Dim cb As BANanoObject = BANano.CallBack(mCallBack, sName, Array(${xarguments}))"$)
			Else
				AddCode(EV, "Dim e As BANanoEvent")
				AddCode(EV, $"Dim cb As BANanoObject = BANano.CallBack(mCallBack, sName, Array(e))"$)
			End If
			AddCode(EV, $"methods.Put(sName, cb)"$)
			AddCode(EV, "End Sub")
			AddNewLine(EV)
			AddCode(EV, $"Sub SetOn${ename}E(s${xname} As String)"$)
			AddCode(EV, $"eOn${ename} = s${xname}"$)
			AddCode(EV, "End Sub")
			AddNewLine(EV)
			'
			'add extra dp
			DP.Append($"#DesignerProperty: Key: On${ename}, DisplayName: On${ename}, FieldType: String, DefaultValue: , Description: Event arguments to be passed to the attribute."$)
			DP.append(CRLF)
			'
			AddCode(VD, $"Private eOn${ename} As String = """$)
			'
			AddCode(RD, $"eOn${ename} = Props.Get("On${ename}")"$)
		Else
			eventname = eventname.tolowercase
			Dim eLine As String = $"#Event: ${eventname} (${eventarguments})"$
			AddCode(CV, eLine)
			'
			eLine = $"mElement.HandleEvents("${eventname}", mCallBack, mEventName & "_${eventname}")"$
			AddCode(EC, eLine)
		End If
	Next
	AddNewLine(CV)
	'
	If projectvue = "Yes" Then
		AddCode(DP, $"#DesignerProperty: Key: Caption, DisplayName: Caption, FieldType: String, DefaultValue: , Description: Text on the element"$)
	Else
		AddCode(DP, $"#DesignerProperty: Key: Text, DisplayName: Text, FieldType: String, DefaultValue: , Description: Text on the element"$)
	End If
	AddCode(DP, $"#DesignerProperty: Key: Classes, DisplayName: Classes, FieldType: String, DefaultValue: , Description: Classes added to the HTML tag."$)
	AddCode(DP, $"#DesignerProperty: Key: Style, DisplayName: Style, FieldType: String, DefaultValue: , Description: Styles added to the HTML tag. Must be a json String."$)
	AddCode(DP, $"#DesignerProperty: Key: Attributes, DisplayName: Attributes, FieldType: String, DefaultValue: , Description: Attributes added to the HTML tag. Must be a json String."$)
	
	If projectvue = "Yes" Then
		AddCode(DP, $"#DesignerProperty: Key: States, DisplayName: States, FieldType: String, DefaultValue: , Description: Initial Binding States. Must be a json String."$)
	End If
	
	AddCode(DP, "'***** CLASSES *****")
	AddNewLine(DP)
	
	'process classes
	Dim prev As Map = CreateMap()
	For Each class As Map In classes
		Dim classdescription As String = class.get("classdescription")
		classdescription = classdescription.trim
		Dim classdesigner As String = class.get("classdesigner")
		Dim classhasget As String = class.get("classhasget")
		Dim classhasset As String = class.get("classhasset")
		Dim classname As String = class.get("classname")
		classname = classname.trim
		Dim classoptions As String = class.get("classoptions")
		classoptions = classoptions.Trim
		classoptions = RemoveDuplicates(classoptions)
		Dim classoninit As String = class.get("classoninit")
		Dim classonsub As String = class.get("classonsub")
		Dim classtype As String = class.get("classtype")
		Dim defaultvalue As String = class.Get("defaultvalue")
		defaultvalue = defaultvalue.trim
		Dim classaddoncondition As String = class.get("classaddoncondition")
		If classname = "undefined" Then Continue
		'
		classtype = BANanoShared.BeautifyName(classtype)
		If classtype = "Boolean" And defaultvalue = "" Then
			defaultvalue = "False"
		End If
		Dim varPrefix As String = BANanoShared.LeftString(classtype, 2)
		varPrefix = varPrefix.tolowercase
		
		'
		'beautify the class name
		Dim cAttrName As String = vm.BeautifyName(classname)
		If cAttrName = "Type" Then cAttrName = "TypeOf"
		'this is a designer property
		If classdesigner = "Yes" Then
			DP.Append($"#DesignerProperty: Key: ${cAttrName}, DisplayName: ${cAttrName}, FieldType: ${classtype}, DefaultValue: ${defaultvalue} , Description: ${classdescription}"$)
			'read the designer property
			AddCode(RD, $"${varPrefix}${cAttrName} = Props.Get("${cAttrName}")"$)
			'if we have a min & max value
			If classoptions <> "" Then
				DP.append($", List: ${classoptions}"$)
			End If
			'close this designer property
			DP.append(CRLF)
		End If
		'define variable declaration
		VD.append($"Private ${varPrefix}${cAttrName} As ${classtype}"$)
		Select Case classtype
			Case "String", "Int"
				'add the class for building
				AddCode(AA, $"AddClass(${varPrefix}${cAttrName})"$)
			Case "Boolean"
				Select Case classaddoncondition
					Case "True", "False"
						AddCode(AA, $"AddClassOnCondition("${classname}", ${varPrefix}${cAttrName}, ${classaddoncondition})"$)
					Case "None"
						AddCode(AA, $"AddClass("${classname}")"$)
				End Select
		End Select
		'
		Select Case classtype
			Case "String"
				VD.append($" = "${defaultvalue}""$)
			Case "Boolean", "Int"
				If defaultvalue <> "" Then
					VD.append($" = ${defaultvalue}"$)
				End If
		End Select
		'close the variable declaration
		VD.append(CRLF)
		'build gets and sets
		'
		If classhasset = "Yes" Then
			If classdescription <> "" Then
				AddComment(GS, "set " & classdescription)
			Else
				AddComment(GS, "set " & classname)
			End If
			prev.put(classname, classname)
			AddCode(GS, $"public Sub set${cAttrName}(var${cAttrName} As ${classtype})"$)
			Select Case classaddoncondition
				Case "True", "False"
					AddCode(GS, $"AddClassOnCondition("${classname}", var${cAttrName}, ${classaddoncondition})"$)
				Case "None"
					AddCode(GS, $"AddClass(var${cAttrName})"$)
			End Select
			AddCode(GS, $"${varPrefix}${cAttrName} = var${cAttrName}"$)
			AddCode(GS, "End Sub")
			AddNewLine(GS)
		End If
		'
		If classhasget = "Yes" Then
			If classdescription <> "" Then
				AddComment(GS, "get " & classdescription)
			Else
				AddComment(GS, "get " & classname)
			End If
			AddCode(GS, $"public Sub get${cAttrName}() As ${classtype}"$)
			AddCode(GS, $"Return ${varPrefix}${cAttrName}"$)
			AddCode(GS, "End Sub")
			AddNewLine(GS)
		End If
		'
		'make coding easier
		If classoptions <> "" Then
			Dim lclassoptions As List = vm.strparse("|", classoptions)
			For Each soption As String In lclassoptions
				soption = soption.trim
				If soption = "none" Then Continue
				If prev.ContainsKey(soption) Then Continue
				Dim boption As String = vm.BeautifyName(soption)
				AddComment(GS, "add " & soption & " class")
				AddCode(GS, $"public Sub set${boption}()"$)
				AddCode(GS, $"AddClass("${soption}")"$)
				AddCode(GS, "End Sub")
				AddNewLine(GS)
			Next
		End If
	Next
	
	
	AddCode(DP, "'***** ATTRIBUTES *****")
	AddNewLine(DP)
	prev.Initialize 
	For Each attr As Map In attributes
		Dim attrdescription As String = attr.get("attrdescription")
		attrdescription = attrdescription.trim
		Dim attrdesigner As String = attr.get("attrdesigner")
		Dim attrhasget As String = attr.get("attrhasget")
		Dim attrhasset As String = attr.get("attrhasset")
		Dim attrmax As String = attr.get("attrmax")
		Dim attrmin As String = attr.get("attrmin")
		Dim attrname As String = attr.get("attrname")
		attrname = attrname.trim
		Dim attroptions As String = attr.get("attroptions")
		attroptions = attroptions.trim
		attroptions = RemoveDuplicates(attroptions)
		
		Dim attroninit As String = attr.get("attroninit")
		Dim attronsub As String = attr.get("attronsub")
		Dim attrtype As String = attr.get("attrtype")
		Dim defaultvalue As String = attr.Get("defaultvalue")
		defaultvalue = defaultvalue.trim
		Dim oncondition As String = attr.get("oncondition")
		
		If attrname = "undefined" Then Continue
			'
		attrtype = BANanoShared.BeautifyName(attrtype) 
		If attrtype = "Boolean" And defaultvalue = "" Then
			defaultvalue = "False"
		End If
		If attrtype = "Boolean" Then 
			defaultvalue = BANanoShared.beautifyname(defaultvalue)
		End If
		'get left part of type
		Dim varPrefix As String = BANanoShared.LeftString(attrtype, 2)
		varPrefix = varPrefix.tolowercase
		'
		
		'beautify the attribute name
		Dim bAttrName As String = vm.BeautifyName(attrname)
		If bAttrName = "Type" Then bAttrName = "TypeOf"
		'this is a designer property
		If attrdesigner = "Yes" Then
			DP.Append($"#DesignerProperty: Key: ${bAttrName}, DisplayName: ${bAttrName}, FieldType: ${attrtype}, DefaultValue: ${defaultvalue} , Description: ${attrdescription}"$)
			'read the designer property
			AddCode(RD, $"${varPrefix}${bAttrName} = Props.Get("${bAttrName}")"$)
			'if we have a min & max value
			If attrmin <> "" Then DP.append($", MinRange: ${attrmin}"$)
			If attrmax <> "" Then DP.append($", MaxRange: ${attrmax}"$)
			If attroptions <> "" Then
				DP.append($", List: ${attroptions}"$)
			End If
			'close this designer property
			DP.append(CRLF)
		End If
		
		'define variable declaration
		VD.append($"Private ${varPrefix}${bAttrName} As ${attrtype}"$)
		
		Select Case attrtype
		Case "String", "Int"
			'add the class for building
			AddCode(AA, $"AddAttr("${attrname}", ${varPrefix}${bAttrName})"$)
		Case "Boolean"
			Select Case oncondition
			Case "True", "False"
				AddCode(AA, $"AddAttrOnCondition("${attrname}", ${varPrefix}${bAttrName}, ${oncondition})"$)
			Case Else
				AddCode(AA, $"AddAttr("${attrname}", ${varPrefix}${bAttrName})"$)
			End Select
		End Select
		'
		Select Case attrtype
		Case "String"
			VD.append($" = "${defaultvalue}""$)
		Case "Boolean", "Int"
			If defaultvalue <> "" Then
				VD.append($" = ${defaultvalue}"$)
			End If
		End Select
		'close the variable declaration
		VD.append(CRLF)
		'build gets and sets
		'
		If attrhasset = "Yes" Then
			If attrdescription <> "" Then
				AddComment(GS, "set " & attrdescription)
			Else
				AddComment(GS, "set " & attrname)
			End If
			prev.put(attrname, attrname)
			AddCode(GS, $"public Sub set${bAttrName}(var${bAttrName} As ${attrtype})"$)
			Select Case oncondition
			Case "True", "False"
				AddCode(GS, $"AddAttrOnCondition("${attrname}", var${bAttrName}, ${oncondition})"$)
			Case Else
				AddCode(GS, $"AddAttr("${attrname}", var${bAttrName})"$)
			End Select
			AddCode(GS, $"${varPrefix}${bAttrName} = var${bAttrName}"$)
			If attrname.Contains("loremipsum") Then
				AddCode(GS, $"If var${bAttrName} Then setText(BANanoShared.LoremIpsum(1))"$)
			End If
			AddCode(GS, "End Sub")
			AddNewLine(GS)
		End If
		'
		If attrhasget = "Yes" Then
			If attrdescription <> "" Then
				AddComment(GS, "get " & attrdescription)
			Else
				AddComment(GS, "get " & attrname)
			End If
			AddCode(GS, $"public Sub get${bAttrName}() As ${attrtype}"$)
			AddCode(GS, $"Return ${varPrefix}${bAttrName}"$)
			AddCode(GS, "End Sub")
			AddNewLine(GS)
		End If
		'
		'make coding easier
		If attroptions <> "" Then
			Dim lclassoptions As List = vm.strparse("|", attroptions)
			For Each soption As String In lclassoptions
				soption = soption.trim
				If soption = "none" Then Continue
				If prev.containsKey(soption) Then Continue
				Dim boption As String = vm.BeautifyName(soption)
				Dim bAttrName As String = vm.BeautifyName(attrname)
				AddComment(GS, "add " & attrname & "-" & soption & " attribute")
				AddCode(GS, $"public Sub set${bAttrName}${boption}()"$)
				AddCode(GS, $"AddAttr("${attrname}", "${soption}")"$)
				AddCode(GS, "End Sub")
				AddNewLine(GS)
			Next
		End If
	Next
	'
	AddCode(DP, "'***** STYLES *****")
	AddNewLine(DP)
	'coding the styles
	prev.initialize
	For Each style As Map In styles
		Dim styledescription As String = style.get("styledescription")
		styledescription = styledescription.trim
		Dim styledesigner As String = style.get("styledesigner")
		Dim stylehasget As String = style.get("stylehasget")
		Dim stylehasset As String = style.get("stylehasset")
		Dim stylename As String = style.get("stylename")
		stylename = stylename.trim
		Dim styleoptions As String = style.get("styleoptions")
		styleoptions = styleoptions.trim
		styleoptions = RemoveDuplicates(styleoptions)
		
		Dim styleoninit As String = style.get("styleoninit")
		Dim styleonsub As String = style.get("styleonsub")
		Dim styletype As String = style.get("styletype")
		Dim defaultvalue As String = style.Get("defaultvalue")
		defaultvalue = defaultvalue.trim
		If stylename = "undefined" Then Continue
		'
		styletype = BANanoShared.BeautifyName(styletype)
		If styletype = "Boolean" And defaultvalue = "" Then
			defaultvalue = "False"
		End If
		Dim varPrefix As String = BANanoShared.LeftString(styletype, 2)
		varPrefix = varPrefix.tolowercase
		'
		'beautify the attribute name
		Dim sAttrName As String = vm.BeautifyName(stylename)
		If sAttrName = "Type" Then sAttrName = "TypeOf"
		'this is a designer property
		If styledesigner = "Yes" Then
			DP.Append($"#DesignerProperty: Key: ${sAttrName}, DisplayName: ${sAttrName}, FieldType: ${styletype}, DefaultValue: ${defaultvalue} , Description: ${styledescription}"$)
			'read the designer property
			AddCode(RD, $"${varPrefix}${sAttrName} = Props.Get("${sAttrName}")"$)
			'if we have a min & max value
			If styleoptions <> "" Then
				DP.append($", List: ${styleoptions}"$)
			End If
		End If 
		'close this designer property
		DP.append(CRLF)
		'define variable declaration
		VD.append($"Private ${varPrefix}${sAttrName} As ${styletype}"$)
		'add the style for building
		AddCode(AA, $"AddStyle("${stylename}", ${varPrefix}${sAttrName})"$)
		'
		Select Case attrtype
			Case "String"
				VD.append($" = "${defaultvalue}""$)
			Case "Boolean", "Int"
				If defaultvalue <> "" Then
					VD.append($" = ${defaultvalue}"$)
				End If
		End Select
		'close the variable declaration
		VD.append(CRLF)
		'build gets and sets
		'
		If stylehasset = "Yes" Then
			If styledescription <> "" Then
				AddComment(GS, "set " & styledescription)
			Else
				AddComment(GS, "set " & stylename)
			End If
			prev.put(stylename, stylename)
			AddCode(GS, $"public Sub set${sAttrName}(var${sAttrName} As ${styletype})"$)
			AddCode(GS, $"AddStyle("${stylename}", var${sAttrName})"$)
			AddCode(GS, $"${varPrefix}${sAttrName} = var${sAttrName}"$)
			AddCode(GS, "End Sub")
			AddNewLine(GS)
		End If
		'
		If stylehasget = "Yes" Then
			If styledescription <> "" Then
				AddComment(GS, "get " & styledescription)
			Else
				AddComment(GS, "get " & stylename)
			End If
			AddCode(GS, $"public Sub get${sAttrName}() As ${styletype}"$)
			AddCode(GS, $"Return ${varPrefix}${sAttrName}"$)
			AddCode(GS, "End Sub")
			AddNewLine(GS)
		End If
		'
		'make coding easier
		If styleoptions <> "" Then
			Dim lclassoptions As List = vm.strparse("|", styleoptions)
			For Each soption As String In lclassoptions
				soption = soption.trim
				If soption = "none" Then Continue
				If prev.ContainsKey(soption) Then Continue
				Dim boption As String = vm.BeautifyName(soption)
				Dim sAttrName As String = vm.BeautifyName(stylename)
				AddComment(GS, "add " & attrname & "-" & soption & " style")
				AddCode(GS, $"public Sub set${sAttrName}${boption}()"$)
				AddCode(GS, $"AddStyle("${stylename}", "${soption}")"$)
				AddCode(GS, "End Sub")
				AddNewLine(GS)
			Next
		End If		
	Next
	'
	
	
	'update the code
	
	'add designer properties
	CV.append(DP.ToString)
	AddNewLine(CV)
	'
	'add class globals
	AddCode(CV, "Sub Class_Globals")
	AddCode(CV, "Private BANano As BANano 'ignore")
	AddCode(CV, $"Private mName As String 'ignore"$)
	AddCode(CV, "Private mEventName As String 'ignore")
	AddCode(CV, "Private mCallBack As Object 'ignore")
	AddCode(CV, "Private mTarget As BANanoElement 'ignore")
	AddCode(CV, "Private mElement As BANanoElement 'ignore")
	AddCode(CV, $"Private mClasses As String = """$)
	AddCode(CV, $"Private mStyle As String = """$)
	AddCode(CV, $"Private mAttributes As String = """$)
	If projectvue = "Yes" Then
		AddCode(CV, $"Private mCaption As String = """$)
	Else
		AddCode(CV, $"Private mText As String = """$)
	End If
	AddCode(CV, $"Private classList As Map"$)
	AddCode(CV, $"Private styleList As Map"$)
	AddCode(CV, $"Private attributeList As Map"$)
	AddCode(CV, $"Private mTagName As String = "${tagName}""$)
	AddCode(CV, "Private sbText As StringBuilder")
	If projectvue = "Yes" Then
		AddCode(CV, "Private mStates As String")
		AddCode(CV, $"Public bindings As Map"$)
		AddCode(CV, $"Public methods As Map"$)
	End If
	CV.append(VD.tostring)
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	'
	'initialize the custom view
	AddComment(CV, "initialize the custom view")
	AddCode(CV, $"Public Sub Initialize (CallBack As Object, Name As String, EventName As String)"$)
	AddCode(CV, $"mName = Name.ToLowerCase"$)
	AddCode(CV, $"mEventName = EventName.ToLowerCase"$)
	AddCode(CV, "mCallBack = CallBack")
	AddCode(CV, "classList.Initialize")
	AddCode(CV, "styleList.Initialize")
	AddCode(CV, "attributeList.Initialize")
	AddCode(CV, "sbText.Initialize")
	'this is a vue project
	If projectvue = "Yes" Then
		AddCode(CV, "bindings.Initialize")
		AddCode(CV, "methods.Initialize")
	End If
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	
	AddComment(CV, "Create view in the designer")
	AddCode(CV, $"Public Sub DesignerCreateView (Target As BANanoElement, Props As Map)"$)
	AddCode(CV, "mTarget = Target")
	AddCode(CV, "If Props <> Null Then")
	AddCode(CV, $"mClasses = Props.Get("Classes")"$)
	AddCode(CV, $"mAttributes = Props.Get("Attributes")"$)
	AddCode(CV, $"mStyle = Props.Get("Style")"$)
	If projectvue = "Yes" Then
		AddCode(CV, $"mCaption = Props.Get("Caption")"$)
	Else
		AddCode(CV, $"mText = Props.Get("Text")"$)
	End If
	'
	If projectvue = "Yes" Then
		AddCode(CV, $"mStates = Props.Get("States")"$)
	End If
	'
	CV.append(RD.tostring)
	AddCode(CV, "End If")
	AddNewLine(CV)
	CV.Append(AA.Tostring)
	AddCode(CV, $"AddClass(mClasses)"$)
	AddCode(CV, $"setAttributes(mAttributes)"$)
	AddCode(CV, $"setStyles(mStyle)"$)
	'
	If projectvue = "Yes" Then
		AddCode(CV, $"SetStates(mStates)"$)
	End If
	
	AddNewLine(CV)
	
	If projectvue = "Yes" Then
		AddComment(CV, "link the events, if any")
		AddCode(CV, EC.ToString)
	End If
	AddComment(CV, "build and get the element")
	AddCode(CV, $"Dim strHTML As String = ToString"$)
	AddCode(CV, $"mElement = mTarget.Append(strHTML).Get("#" & mName)"$)
	If projectvue = "No" Then
		AddComment(CV, "add events for the custom view, if any")
	 	AddCode(CV, EC.ToString)
	End If
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	
	AddComment(CV, "return the generated html")
	AddCode(CV, "Sub ToString As String")
	AddComment(CV, "build the 'class' attribute")
	AddCode(CV, $"Dim className As String = BANanoShared.JoinMapKeys(classList, " ")"$)
	AddCode(CV, $"AddAttr("class", className)"$)
	AddComment(CV, "build the 'style' attribute")
	AddCode(CV, $"Dim styleName As String = BANanoShared.BuildStyle(styleList)"$)
	AddCode(CV, $"AddAttr("style", styleName)"$)
	AddComment(CV, "build element internal structure")
	AddCode(CV, $"Dim iStructure As String = BANanoShared.BuildAttributes(attributeList)"$)
	AddCode(CV, "iStructure = iStructure.trim")
	Dim cvCode As String = $"Dim rslt As String = ~"<~{mTagName} id="~{mName}" ~{iStructure}>~{mText}~{sbText.ToString}</~{mTagName}>"~"$
	cvCode = cvCode.replace("~", "$")
	If projectvue = "Yes" Then
		cvCode = cvCode.replace("mText", "mCaption")
	End If
	AddCode(CV, cvCode)
	AddCode(CV, "Return rslt")
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	
	'this is a vue project
	If projectvue = "Yes" Then
		AddComment(CV, $"bind an attribute"$)
		AddCode(CV, $"Sub SetVBind(prop As String, value As String)"$)
		AddCode(CV, "prop = prop.ToLowerCase")
		AddCode(CV, "value = value.ToLowerCase")
		Dim sline As String = $"prop = ~"v-bind:~{prop}"~"$
		AddCode(CV, sline.replace("~", "$"))
		AddCode(CV, "AddAttr(prop,value)")
		AddCode(CV, $"bindings.Put(value, Null)"$)
		AddCode(CV, "End Sub")
		AddNewLine(CV)
		'
		AddComment(CV, "add html of component to app and this binds events and states")
		AddCode(CV, "Sub AddToApp(vap As VueApp)")
		AddCode(CV, "'Dim sout As String = ToString")
		AddCode(CV, "'vap.AddHTML(sout)")
		AddComment(CV, "apply the binding for the control")
		AddCode(CV, "For Each k As String In bindings.Keys")
		AddCode(CV, "Dim v As Object = bindings.Get(k)")
		AddCode(CV, "vap.SetData(k, v)")
		AddCode(CV, "Next")
		AddComment(CV, "apply the events")
		AddCode(CV, "For Each k As String In methods.Keys")
		AddCode(CV, "Dim cb As BANanoObject = methods.Get(k)")
		AddCode(CV, "vap.SetCallBack(k, cb)")
		AddCode(CV, "Next")
		AddCode(CV, "End Sub")
		AddNewLine(CV)
		'
		AddComment(CV, "bind component to app")
		AddCode(CV, "Sub BindToApp(vap As VueApp)")
		AddComment(CV, "apply the binding for the control")
		AddCode(CV, "For Each k As String In bindings.Keys")
		AddCode(CV, "Dim v As Object = bindings.Get(k)")
		AddCode(CV, "vap.SetData(k, v)")
		AddCode(CV, "Next")
		AddComment(CV, "apply the events")
		AddCode(CV, "For Each k As String In methods.Keys")
		AddCode(CV, "Dim cb As BANanoObject = methods.Get(k)")
		AddCode(CV, "vap.SetCallBack(k, cb)")
		AddCode(CV, "Next")
		AddCode(CV, "End Sub")
		AddNewLine(CV)
		
		'
		AddComment(CV, "add html of component to another and binds events and states")
		AddCode(CV, "Sub AddToComponent(ve As VueComponent)")
		AddCode(CV, "'Dim sout As String = ToString")
		AddCode(CV, "'ve.AddHTML(sout)")
		AddComment(CV, "apply the binding for the control")
		AddCode(CV, "For Each k As String In bindings.Keys")
		AddCode(CV, "Dim v As Object = bindings.Get(k)")
		AddCode(CV, "ve.SetData(k, v)")
		AddCode(CV, "Next")
		AddComment(CV, "apply the events")
		AddCode(CV, "For Each k As String In methods.Keys")
		AddCode(CV, "Dim cb As BANanoObject = methods.Get(k)")
		AddCode(CV, "ve.SetCallBack(k, cb)")
		AddCode(CV, "Next")
		AddCode(CV, "End Sub")
		AddNewLine(CV)
		'
		AddComment(CV, "binds events and states")
		AddCode(CV, "Sub BindToComponent(ve As VueComponent)")
		AddComment(CV, "apply the binding for the control")
		AddCode(CV, "For Each k As String In bindings.Keys")
		AddCode(CV, "Dim v As Object = bindings.Get(k)")
		AddCode(CV, "ve.SetData(k, v)")
		AddCode(CV, "Next")
		AddComment(CV, "apply the events")
		AddCode(CV, "For Each k As String In methods.Keys")
		AddCode(CV, "Dim cb As BANanoObject = methods.Get(k)")
		AddCode(CV, "ve.SetCallBack(k, cb)")
		AddCode(CV, "Next")
		AddCode(CV, "End Sub")
		AddNewLine(CV)
		'
		AddComment(CV, "initialize data")
		AddCode(CV, "Sub SetData(prop as string, val as Object)")
		AddCode(CV, "bindings.Put(prop, val)")
		AddCode(CV, "End Sub")
		AddNewLine(CV)
		'
		AddComment(CV, "sets the state bindings")
		AddCode(CV, "public Sub SetStates(varBindings As String)")
		AddCode(CV, $"if varBindings = "" Then Return"$)
		AddCode(CV, $"Dim mxItems As List = BANanoShared.StrParse(";", varBindings)"$)
		AddCode(CV, $"For Each mt As String In mxItems"$)
		AddCode(CV, $"Dim k As String = BANanoShared.MvField(mt,1,"=")"$)
		AddCode(CV, $"Dim v As String = BANanoShared.MvField(mt,2,"=")"$)
		AddCode(CV, $"If v.EqualsIgnoreCase("false") Then"$)
		AddCode(CV, $"bindings.Put(k, False)"$)
		AddCode(CV, $"else if v.EqualsIgnoreCase("true") Then"$)
		AddCode(CV, $"bindings.Put(k, True)"$)
		AddCode(CV, $"Else"$)
		AddCode(CV, $"bindings.put(k, v)"$)
		AddCode(CV, "End If")
		AddCode(CV, "Next")
		AddCode(CV, "End Sub")
		AddNewLine(CV)
		'add element to text
		AddComment(CV, "add an element to the text")
		AddCode(CV, $"Sub AddElement(elID As String, tag As String, props As Map, styleProps As Map, classNames As List, loose As List, Text As String)"$)
		AddCode(CV, $"elID = elID.tolowercase"$)
		AddCode(CV, $"elID = elID.Replace("#","")"$)
		AddCode(CV, $"Dim elIT As VueElement"$)
		AddCode(CV, $"elIT.Initialize(mCallBack, elID, tag)"$)
		AddCode(CV, $"elIT.SetText(Text)"$)
		'
		AddCode(CV, $"If loose <> Null Then"$)
		AddCode(CV, $"For Each k As String In loose"$)
		AddCode(CV, $"elIT.SetAttr(k, True)"$)
		AddCode(CV, "Next")
		AddCode(CV, "End If")
		'
		AddCode(CV, $"If props <> Null Then"$)
		AddCode(CV, $"For Each k As String In props.Keys"$)
		AddCode(CV, $"Dim v As String = props.Get(k)"$)
		AddCode(CV, $"elIT.SetAttr(k, v)"$)
		AddCode(CV, "Next")
		AddCode(CV, "End If")
		'
		AddCode(CV, $"If styleProps <> Null Then"$)
		AddCode(CV, $"For Each k As String In styleProps.Keys"$)
		AddCode(CV, $"Dim v As String = styleProps.Get(k)"$)
		AddCode(CV, $"elIT.SetAttr(k, v)"$)
		AddCode(CV, "Next")
		AddCode(CV, "End If")
		'
		AddCode(CV, $"If classNames <> Null Then"$)
		AddCode(CV, $"elIT.AddClasses(classNames)"$)
		AddCode(CV, "End If")
		AddComment(CV, "convert to string")
		AddCode(CV, $"Dim sElement As String = elIT.tostring"$)
		AddCode(CV, $"sbText.Append(sElement)"$)
		'
		AddCode(CV, "End Sub")
		AddNewLine(CV)
	End If
	'
	'add a break
	AddComment(CV, "add a break")
	AddCode(CV, "Sub AddBR")
	AddCode(CV, $"sbText.Append("<br>")"$)
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	'add a HR
	AddComment(CV, "add a horizontal rule")
	AddCode(CV, "Sub AddHR")
	AddCode(CV, $"sbText.Append("<hr>")"$)
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	
		
	'
	AddComment(CV, "returns the BANanoElement")
	AddCode(CV, $"public Sub getElement() As BANanoElement"$)
	AddCode(CV, $"Return mElement"$)
	AddCode(CV, $"End Sub"$)
	AddNewLine(CV)
	'
	AddComment(CV, "returns the tag id")
	AddCode(CV, $"public Sub getID() As String"$)
	AddCode(CV, $"Return mName"$)
	AddCode(CV, $"End Sub"$)
	AddNewLine(CV)
	'
	AddComment(CV, "add the element to the parent")
	AddCode(CV, "public Sub AddToParent(targetID As String)")
	AddCode(CV, $"mTarget = BANano.GetElement("#" & targetID.ToLowerCase)"$)
	AddCode(CV, $"DesignerCreateView(mTarget, Null)"$)
	AddCode(CV, $"End Sub"$)
	AddNewLine(CV)
	'
	AddComment(CV, "remove the component")
	AddCode(CV, $"public Sub Remove()"$)
	AddCode(CV, $"mElement.Remove"$)
	AddCode(CV, $"BANano.SetMeToNull"$)
	AddCode(CV, $"End Sub"$)
	AddNewLine(CV)
	AddComment(CV, "trigger an event")
	AddCode(CV, $"public Sub Trigger(event As String, params() As String)"$)
	AddCode(CV, $"If mElement <> Null Then"$)
	AddCode(CV, "mElement.Trigger(event, params)")
	AddCode(CV, "End If")
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	AddComment(CV, "add a class")
	AddCode(CV, $"public Sub AddClass(varClass As String)"$)
	AddCode(CV, $"If BANano.IsUndefined(varClass) Or BANano.IsNull(varClass) Then Return"$)
	AddCode(CV, $"If BANano.IsNumber(varClass) Then varClass = BANanoShared.CStr(varClass)"$)
	AddCode(CV, $"varClass = varClass.trim"$)
	AddCode(CV, $"if varClass = "" Then Return"$)
	AddCode(CV, $"if varClass = "none" Then Return"$)
	AddCode(CV, $"If mElement <> Null Then mElement.AddClass(varClass)"$)
	AddCode(CV, $"Dim mxItems As List = BANanoShared.StrParse(" ", varClass)"$)
	AddCode(CV, $"For Each mt As String In mxItems"$)
	AddCode(CV, $"classList.put(mt, mt)"$)
	AddCode(CV, "Next")
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	AddComment(CV, "add a class on condition")
	AddCode(CV, $"public Sub AddClassOnCondition(varClass As String, varCondition As Boolean, varShouldBe As boolean)"$)
	AddCode(CV, $"If BANano.IsUndefined(varCondition) Or BANano.IsNull(varCondition) Then Return"$)
	AddCode(CV, $"if varShouldBe <> varCondition Then Return"$)
	AddCode(CV, $"If BANano.IsUndefined(varClass) Or BANano.IsNull(varClass) Then Return"$)
	AddCode(CV, $"If BANano.IsNumber(varClass) Then varClass = BANanoShared.CStr(varClass)"$)
	AddCode(CV, $"varClass = varClass.trim"$)
	AddCode(CV, $"if varClass = "" Then Return"$)
	AddCode(CV, $"if varClass = "none" Then Return"$)
	AddCode(CV, $"If mElement <> Null Then mElement.AddClass(varClass)"$)
	AddCode(CV, $"Dim mxItems As List = BANanoShared.StrParse(" ", varClass)"$)
	AddCode(CV, $"For Each mt As String In mxItems"$)
	AddCode(CV, $"classList.put(mt, mt)"$)
	AddCode(CV, "Next")
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	AddComment(CV, "add a style")
	AddCode(CV, "public Sub AddStyle(varProp As string, varStyle As String)")
	AddCode(CV, $"If BANano.IsUndefined(varStyle) Or BANano.IsNull(varStyle) Then Return"$)
	AddCode(CV, $"If BANano.IsNumber(varStyle) Then varStyle = BANanoShared.CStr(varStyle)"$)
	AddCode(CV, $"if varStyle = "none" Then Return"$)
	AddCode(CV, "If mElement <> Null Then")
	AddCode(CV, "Dim aStyle As Map = CreateMap()")
	AddCode(CV, "aStyle.put(varProp, varStyle)")
	AddCode(CV, "Dim sStyle As String = BANano.ToJSON(aStyle)")
	AddCode(CV, "mElement.SetStyle(sStyle)")
	AddCode(CV, "End If")
	AddCode(CV, $"styleList.put(varProp, varStyle)"$)
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	'
	If projectvue = "Yes" Then	
	AddCode(CV, $"'add an attribute"$)
AddCode(CV, $"Public Sub AddAttr(varProp As String, varValue As String)
If BANano.IsUndefined(varValue) Or BANano.IsNull(varValue) Then Return
If BANano.IsNumber(varValue) Then varValue = BANanoShared.CStr(varValue)
'we are adding a boolean
If BANano.IsBoolean(varValue) Then
If varValue = True Then 
attributeList.put(varProp, varValue)
If mElement <> Null Then mElement.SetAttr(varProp, varValue)
End If
Else
'we are adding a string
If varValue.StartsWith(":") Then
If varValue.StartsWith("~") Then
attributeList.put(varProp, varValue)
If mElement <> Null Then mElement.SetAttr(varProp, varValue)
Else
Dim rname As String = BANanoShared.MidString2(varValue, 2)
If rname.Contains(".") = False Then bindings.Put(rname, Null)
attributeList.put(~":~{varProp}"~, rname)
If mElement <> Null Then mElement.SetAttr(~":~{varProp}"~, rname)
End If
Else
'does not start with :
If mElement <> Null Then mElement.SetAttr(varProp, varValue)
attributeList.put(varProp, varValue)
Select Case varProp
Case "v-model", "v-show", "v-if", "required", "disabled", "readonly"
bindings.Put(varValue, Null)
End Select
End If
End If
Return
End Sub"$)
	Else
		AddCode(CV, $"'add an attribute"$)
		AddCode(CV, $"Public Sub AddAttr(varProp As String, varValue As String)"$)
		AddCode(CV, $"If BANano.IsUndefined(varValue) Or BANano.IsNull(varValue) Then Return
	If BANano.IsNumber(varValue) Then varValue = BANanoShared.CStr(varValue)
	If varValue = "none" Then Return
	attributeList.put(varProp, varValue)
	If mElement <> Null Then mElement.SetAttr(varProp, varValue)"$)
		AddCode(CV, "End Sub")
		AddCode(CV, "")
	End If
	'
	AddComment(CV, "add attr on condition")
	AddCode(CV, $"public Sub AddAttrOnCondition(varProp As String, varCondition As Boolean, varShouldBe As boolean)"$)
	AddCode(CV, $"If BANano.IsUndefined(varProp) Or BANano.IsNull(varProp) Then Return"$)
	AddCode(CV, $"If BANano.IsUndefined(varCondition) Or BANano.IsNull(varCondition) Then Return"$)
	AddCode(CV, $"if varShouldBe <> varCondition Then Return"$)
	AddCode(CV, $"AddAttr(varProp, varCondition)"$)
	AddCode(CV, "End Sub")
	AddNewLine(CV)
		
	AddNewLine(CV)
	AddComment(CV, "returns the class names")
	AddCode(CV, "Public Sub getClasses() As String")
	AddCode(CV, "Dim sbClass As StringBuilder")
	AddCode(CV, "sbClass.Initialize")
	AddCode(CV, "For each k As String in classList.Keys")
	AddCodeInline(CV, "sbClass.Append(k).Append(")
	AddCode(CV, $"" ")"$)
	AddCode(CV, "Next")
	AddCode(CV, $"mClasses = sbClass.ToString"$)
	AddCode(CV, $"Return mClasses"$)
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	AddComment(CV, "set the style use a valid JSON string with {}")
	AddCode(CV, "public Sub setStyle(varStyle As String)")
	AddCode(CV, "If mElement <> Null Then")
	AddCode(CV, "mElement.SetStyle(varStyle)")
	AddCode(CV, "End If")
	AddCode(CV, $"Dim mres as Map = BANano.FromJSON(varStyle)"$)
	AddCode(CV, $"For each k As String in mres.Keys"$)
	AddCode(CV, $"Dim v As String = mres.Get(k)"$)
	AddCode(CV, $"styleList.put(k, v)"$)
	AddCode(CV, $"Next"$)
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	AddComment(CV, "returns the style as JSON")
	AddCode(CV, "public Sub getStyle() As String")
	AddCode(CV, "Dim sbStyle As StringBuilder")
	AddCode(CV, "sbStyle.Initialize")
	AddCode(CV, $"sbStyle.Append("{")"$)
	AddCode(CV, "For each k As String in styleList.Keys")
	AddCode(CV, "Dim v As String = styleList.Get(k)")
	AddCodeInline(CV, "sbStyle.Append(k).Append(")
	AddCodeInline(CV, $"":").Append(v).Append("$)
	AddCode(CV, $"",")"$)
	AddCode(CV, "Next")
	AddCode(CV, $"sbStyle.Append("}")"$)
	AddCode(CV, $"mStyle = sbStyle.ToString"$)	
	AddCode(CV, $"Return mStyle"$)
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	AddComment(CV, "sets the attributes")
	AddCode(CV, "public Sub setAttributes(varAttributes As String)")
	AddCode(CV, $"If varAttributes.IndexOf("=") >= 0 Then varAttributes = varAttributes.Replace("=",":")"$)
	If projectvue <> "Yes" Then
		AddCode(CV, $"If varAttributes.IndexOf(",") >= 0 Then varAttributes = varAttributes.Replace(",",";")"$)
	End If
	AddCode(CV, $"Dim mxItems As List = BANanoShared.StrParse(";", varAttributes)"$)
	AddCode(CV, $"For Each mt As String In mxItems"$)
	AddCode(CV, $"Dim k As String = BANanoShared.MvField(mt,1,":")"$)
	AddCode(CV, $"Dim v As String = BANanoShared.MvField(mt,2,":")"$)
	AddCode(CV, $"If mElement <> Null Then mElement.SetAttr(k, v)"$)
	AddCode(CV, $"attributeList.put(k, v)"$)
	AddCode(CV, "Next")
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	
	
	AddComment(CV, "sets the styles from the designer")
	AddCode(CV, "public Sub setStyles(varStyles As String)")
	AddCode(CV, $"If varStyles.IndexOf("=") >= 0 Then varStyles = varStyles.Replace("=",":")"$)
	If projectvue <> "Yes" Then
		AddCode(CV, $"If varStyles.IndexOf(",") >= 0 Then varStyles = varStyles.Replace(",",";")"$)
	End If
	AddCode(CV, $"Dim mxItems As List = BANanoShared.StrParse(";", varStyles)"$)
	AddCode(CV, $"For Each mt As String In mxItems"$)
	AddCode(CV, $"Dim k As String = BANanoShared.MvField(mt,1,":")"$)
	AddCode(CV, $"Dim v As String = BANanoShared.MvField(mt,2,":")"$)
	AddCode(CV, $"AddStyle(k, v)"$)
	AddCode(CV, "Next")
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	AddComment(CV, "returns the attributes")
	AddCode(CV, "public Sub getAttributes() As String")
	AddCode(CV, "Dim sbAttr As StringBuilder")
	AddCode(CV, "sbAttr.Initialize")
	AddCode(CV, "For each k As String in attributeList.Keys")
	AddCode(CV, "Dim v As String = attributeList.Get(k)")
	AddCodeInline(CV, "sbAttr.Append(k).Append(")
	AddCode(CV, $""=").Append(v).Append(";")"$)
	AddCode(CV, "Next")
	AddCode(CV, $"mAttributes = sbAttr.ToString"$)
	AddCode(CV, $"Return mAttributes"$)
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	If projectvue = "Yes" Then
		AddComment(CV, "sets the caption")
		AddCode(CV, "public Sub setCaption(varText As String)")
		AddCode(CV, "If mElement <> Null Then")
		AddCode(CV, "mElement.SetHTML(BANano.SF(varText))")
		AddCode(CV, "End If")
		AddCode(CV, "mCaption = varText")
		AddCode(CV, "End Sub")
		AddNewLine(CV)
		AddComment(CV, "returns the text")
		AddCode(CV, "public Sub getCaption() As String")
		AddCode(CV, "Return mCaption")
		AddCode(CV, "End Sub")
	Else
		AddComment(CV, "sets the text")
		AddCode(CV, "public Sub setText(varText As String)")
		AddCode(CV, "If mElement <> Null Then")
		AddCode(CV, "mElement.SetHTML(BANano.SF(varText))")
		AddCode(CV, "End If")
		AddCode(CV, "mText = varText")
		AddCode(CV, "End Sub")
		AddNewLine(CV)
		AddComment(CV, "returns the text")
		AddCode(CV, "public Sub getText() As String")
		AddCode(CV, "Return mText")
		AddCode(CV, "End Sub")
	End If
	AddNewLine(CV)
	CV.append(GS.tostring)
	AddNewLine(CV)
	'
	AddComment(CV, "add a child component")
	AddCode(CV, $"Sub AddChild(child As String)"$)
	AddCode(CV, "sbText.Append(child)")
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	'
	CV.append(EV.tostring)
	
	Return CV.tostring
End Sub

Sub GetVariablesFromArguments(values As String) As String
	Dim lItems As List = BANanoShared.newlist
	Dim spItems As List = BANanoShared.StrParse(",", values)
	For Each sitem As String In spItems
		Dim xitem As String = BANanoShared.MvField(sitem,1," ")
		xitem = xitem.trim
		lItems.add(xitem)
	Next
	Dim sout As String = BANanoShared.Join(",",lItems)
	Return sout 
End Sub

private Sub AddNewLine(sbx As StringBuilder)
	sbx.Append(CRLF)
End Sub

private Sub AddComment(sbx As StringBuilder, xcode As String)
	sbx.Append("'" & xcode).Append(CRLF)
End Sub

private Sub AddCode(sbx As StringBuilder, xcode As String)
	xcode = xcode.replace("~","$")
	sbx.Append(xcode).Append(CRLF)
End Sub


private Sub AddCodeInline(sbx As StringBuilder, xcode As String)
	xcode = xcode.replace("~","$")
	sbx.Append(xcode)
End Sub

Sub RemoveDuplicates(soptions As String) As String
	If soptions = "" Then Return ""
	Dim lclassoptions As List = vm.strparse("|", soptions)
	Dim nm As Map = CreateMap()
	For Each soption As String In lclassoptions
		soption = soption.trim
		nm.put(soption, soption)
	Next
	Dim nl As List
	nl.initialize
	For Each k As String In nm.keys
		nl.add(k)
	Next
	nl.sort(True)
	Dim sout As String = BANanoShared.Join("|", nl)
	Return sout
End Sub

