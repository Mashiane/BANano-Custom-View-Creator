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
	'event handling
	Dim EC As StringBuilder
	EC.Initialize
	
	AddCode(CV, "B4J=true")
	AddCode(CV, "Group=Default Group")
	AddCode(CV, "ModulesStructureVersion=1")
	AddCode(CV, "Type=Class")
	AddCode(CV, "Version=7")
	AddCode(CV, "@EndOfDesignText@")
	AddComment(CV, "Custom BANano View class")
	AddNewLine(CV)
	'add the events
	For Each event As Map In events
		Dim eventname As String = event.get("eventname")
		Dim eventarguments As String = event.Get("eventarguments")
		Dim eventactive As String = event.get("eventactive")
		If eventactive = "No" Then Continue
		'
		eventname = eventname.tolowercase
		Dim eLine As String = $"#Event: ${eventname} (${eventarguments})"$
		AddCode(CV, eLine)
		'add code to handle the event
		eLine = $"mElement.HandleEvents("${eventname}", mCallBack, mEventName & "_${eventname}")"$
		AddCode(EC, eLine)
	Next
	AddNewLine(CV)
	'
	'variable declarations
	Dim VD As StringBuilder
	VD.initialize
	
	'designer properties
	Dim DP As StringBuilder
	DP.initialize
	
	'gets and sets
	Dim GS As StringBuilder
	GS.initialize
	
	'read desiner properties
	Dim RD As StringBuilder
	RD.initialize
	
	'all attributes
	Dim AA As StringBuilder
	AA.initialize
	'
	AddCode(DP, $"#DesignerProperty: Key: Text, DisplayName: Text, FieldType: String, DefaultValue: , Description: Text on the element"$)
	AddCode(DP, $"#DesignerProperty: Key: Classes, DisplayName: Classes, FieldType: String, DefaultValue: , Description: Classes added to the HTML tag."$)
	AddCode(DP, $"#DesignerProperty: Key: Style, DisplayName: Style, FieldType: String, DefaultValue: , Description: Styles added to the HTML tag. Must be a json String."$)
	AddCode(DP, $"#DesignerProperty: Key: Attributes, DisplayName: Attributes, FieldType: String, DefaultValue: , Description: Attributes added to the HTML tag. Must be a json String."$)
	
	For Each attr As Map In attributes
		Dim attrdescription As String = attr.get("attrdescription")
		Dim attrdesigner As String = attr.get("attrdesigner")
		Dim attrhasget As String = attr.get("attrhasget")
		Dim attrhasset As String = attr.get("attrhasset")
		Dim attrmax As String = attr.get("attrmax")
		Dim attrmin As String = attr.get("attrmin")
		Dim attrname As String = attr.get("attrname")
		Dim attroptions As String = attr.get("attroptions")
		Dim attroninit As String = attr.get("attroninit")
		Dim attronsub As String = attr.get("attronsub")
		Dim attrtype As String = attr.get("attrtype")
		Dim defaultvalue As String = attr.Get("defaultvalue")
		'beautify the attribute name
		Dim bAttrName As String = vm.BeautifyName(attrname)
		'this is a designer property
		If attrdesigner = "Yes" Then
			DP.Append($"#DesignerProperty: Key: ${bAttrName}, DisplayName: ${bAttrName}, FieldType: ${attrtype}, DefaultValue: ${defaultvalue} , Description: ${attrdescription}"$)
			'read the designer property
			AddCode(RD, $"m${bAttrName} = Props.Get("${bAttrName}")"$)
		End If
		'if we have a min & max value
		If attrmin <> "" Then DP.append($", MinRange: ${attrmin}"$)
		If attrmax <> "" Then DP.append($", MaxRange: ${attrmax}"$)
		If attroptions <> "" Then
			DP.append($", List: ${attroptions}"$)
		End If
		'close this designer property
		DP.append(CRLF)
		'define variable declaration
		VD.append($"Private m${bAttrName} As ${attrtype}"$)
		'add the attribute for building
		AddCode(AA, $"AddAttr("${attrname}", m${bAttrName})"$)
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
			End If
			AddCode(GS, $"public Sub set${bAttrName}(var${bAttrName} As ${attrtype})"$)
			AddCode(GS, $"AddAttr("${attrname}", var${bAttrName})"$)
			AddCode(GS, $"m${bAttrName} = var${bAttrName}"$)
			AddCode(GS, "End Sub")
			AddNewLine(GS)
		End If
		'
		If attrhasget = "Yes" Then
			If attrdescription <> "" Then
				AddComment(GS, "get " & attrdescription)
			End If
			AddCode(GS, $"public Sub get${bAttrName}() As ${attrtype}"$)
			AddCode(GS, $"Return m${bAttrName}"$)
			AddCode(GS, "End Sub")
			AddNewLine(GS)
		End If
	Next
	'
	'coding the styles
	For Each style As Map In styles
		Dim styledescription As String = style.get("styledescription")
		Dim styledesigner As String = style.get("styledesigner")
		Dim stylehasget As String = style.get("stylehasget")
		Dim stylehasset As String = style.get("stylehasset")
		Dim stylename As String = style.get("stylename")
		Dim styleoptions As String = style.get("styleoptions")
		Dim styleoninit As String = style.get("styleoninit")
		Dim styleonsub As String = style.get("styleonsub")
		Dim styletype As String = style.get("styletype")
		Dim defaultvalue As String = style.Get("defaultvalue")
		'
		'beautify the attribute name
		Dim sAttrName As String = vm.BeautifyName(stylename)
		'this is a designer property
		If styledesigner = "Yes" Then
			DP.Append($"#DesignerProperty: Key: ${sAttrName}, DisplayName: ${sAttrName}, FieldType: ${styletype}, DefaultValue: ${defaultvalue} , Description: ${styledescription}"$)
			'read the designer property
			AddCode(RD, $"m${sAttrName} = Props.Get("${sAttrName}")"$)
		End If
		'if we have a min & max value
		If styleoptions <> "" Then
			DP.append($", List: ${styleoptions}"$)
		End If
		'close this designer property
		DP.append(CRLF)
		'define variable declaration
		VD.append($"Private m${sAttrName} As ${styletype}"$)
		'add the style for building
		AddCode(AA, $"AddStyle("${stylename}", m${sAttrName})"$)
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
			End If
			AddCode(GS, $"public Sub set${sAttrName}(var${sAttrName} As ${styletype})"$)
			AddCode(GS, $"AddStyle("${stylename}", var${sAttrName})"$)
			AddCode(GS, $"m${sAttrName} = var${sAttrName}"$)
			AddCode(GS, "End Sub")
			AddNewLine(GS)
		End If
		'
		If stylehasget = "Yes" Then
			If styledescription <> "" Then
				AddComment(GS, "get " & styledescription)
			End If
			AddCode(GS, $"public Sub get${sAttrName}() As ${styletype}"$)
			AddCode(GS, $"Return m${sAttrName}"$)
			AddCode(GS, "End Sub")
			AddNewLine(GS)
		End If
	Next
	'process classes
	For Each class As Map In classes
		Dim classdescription As String = class.get("classdescription")
		Dim classdesigner As String = class.get("classdesigner")
		Dim classhasget As String = class.get("classhasget")
		Dim classhasset As String = class.get("classhasset")
		Dim classname As String = class.get("classname")
		Dim classoptions As String = class.get("classoptions")
		Dim classoninit As String = class.get("classoninit")
		Dim classonsub As String = class.get("classonsub")
		Dim classtype As String = class.get("classtype")
		Dim defaultvalue As String = class.Get("defaultvalue")
		'
		'beautify the class name
		Dim cAttrName As String = vm.BeautifyName(classname)
		'this is a designer property
		If classdesigner = "Yes" Then
			DP.Append($"#DesignerProperty: Key: ${cAttrName}, DisplayName: ${cAttrName}, FieldType: ${classtype}, DefaultValue: ${defaultvalue} , Description: ${classdescription}"$)
			'read the designer property
			AddCode(RD, $"m${cAttrName} = Props.Get("${cAttrName}")"$)
		End If
		'if we have a min & max value
		If classoptions <> "" Then
			DP.append($", List: ${classoptions}"$)
		End If
		'close this designer property
		DP.append(CRLF)
		'define variable declaration
		VD.append($"Private m${cAttrName} As ${classtype}"$)
		'add the class for building
		AddCode(AA, $"AddClass(m${cAttrName})"$)
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
			End If
			AddCode(GS, $"public Sub set${cAttrName}(var${cAttrName} As ${classtype})"$)
			AddCode(GS, $"AddClass(var${cAttrName})"$)
			AddCode(GS, $"m${cAttrName} = var${cAttrName}"$)
			AddCode(GS, "End Sub")
			AddNewLine(GS)
		End If
		'
		If classhasget = "Yes" Then
			If classdescription <> "" Then
				AddComment(GS, "get " & classdescription)
			End If
			AddCode(GS, $"public Sub get${cAttrName}() As ${classtype}"$)
			AddCode(GS, $"Return m${cAttrName}"$)
			AddCode(GS, "End Sub")
			AddNewLine(GS)
		End If
	Next
	
	
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
	AddCode(CV, $"Private mText As String = """$)
	AddCode(CV, $"Private classList As Map"$)
	AddCode(CV, $"Private styleList As Map"$)
	AddCode(CV, $"Private attributeList As Map"$)
	AddCode(CV, $"Private mTagName As String = "${tagName}""$)
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
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	
	AddComment(CV, "Create view in the designer")
	AddCode(CV, $"Public Sub DesignerCreateView (Target As BANanoElement, Props As Map)"$)
	AddCode(CV, "mTarget = Target")
	AddCode(CV, "If Props <> Null Then")
	AddCode(CV, $"mClasses = Props.Get("Classes")"$)
	AddCode(CV, $"mAttributes = Props.Get("Attributes")"$)
	AddCode(CV, $"mStyle = Props.Get("Style")"$)
	AddCode(CV, $"mText = Props.Get("Text")"$)
	CV.append(RD.tostring)
	AddCode(CV, "End If")
	AddNewLine(CV)
	CV.Append(AA.Tostring)
	AddCode(CV, $"AddClass(mClasses)"$)
	AddCode(CV, $"setAttributes(mAttributes)"$)
	AddCode(CV, $"setStyles(mStyle)"$)
	
	AddNewLine(CV)
	
	AddComment(CV, "build and get the element")
	AddCode(CV, $"Dim strHTML As String = ToString"$)
	AddCode(CV, $"mElement = mTarget.Append(strHTML).Get("#" & mName)"$)
	AddComment(CV, "add events for the custom view, if any")
	AddCode(CV, EC.ToString)
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
	Dim cvCode As String = $"Dim rslt As String = ~"<~{mTagName} id="~{mName}" ~{iStructure}>~{mText}</~{mTagName}>"~"$
	cvCode = cvCode.replace("~", "$")
	AddCode(CV, cvCode)
	AddCode(CV, "Return rslt")
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
	AddCode(CV, $"If mElement <> Null Then mElement.AddClass(varClass)"$)
	AddCode(CV, $"Dim mItems As List = BANanoShared.StrParse(" ", varClass)"$)
	AddCode(CV, $"For Each mt As String In mItems"$)
	AddCode(CV, $"classList.put(mt, mt)"$)
	AddCode(CV, "Next")
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	AddComment(CV, "add a style")
	AddCode(CV, "public Sub AddStyle(varProp As string, varStyle As String)")
	AddCode(CV, $"If BANano.IsUndefined(varStyle) Or BANano.IsNull(varStyle) Then Return"$)
	AddCode(CV, $"If BANano.IsNumber(varStyle) Then varStyle = BANanoShared.CStr(varStyle)"$)
	AddCode(CV, "If mElement <> Null Then")
	AddCode(CV, "Dim aStyle As Map = CreateMap()")
	AddCode(CV, "aStyle.put(varProp, varStyle)")
	AddCode(CV, "Dim sStyle As String = BANano.ToJSON(aStyle)")
	AddCode(CV, "mElement.SetStyle(sStyle)")
	AddCode(CV, "End If")
	AddCode(CV, $"styleList.put(varProp, varStyle)"$)
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	AddComment(CV, "add an attribute")
	AddCode(CV, "public Sub AddAttr(varProp As string, varValue As String)")
	AddCode(CV, $"If BANano.IsUndefined(varValue) Or BANano.IsNull(varValue) Then Return"$)
	AddCode(CV, $"If BANano.IsNumber(varValue) Then varValue = BANanoShared.CStr(varValue)"$)
	AddCode(CV, $"If mElement <> Null Then mElement.SetAttr(varProp, varValue)"$)
	AddCode(CV, $"attributeList.put(varProp, varValue)"$)
	AddCode(CV, "End Sub")
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
	AddCode(CV, $"Dim mItems As List = BANanoShared.StrParse(";", varAttributes)"$)
	AddCode(CV, $"For Each mt As String In mItems"$)
	AddCode(CV, $"Dim k As String = BANanoShared.MvField(mt,1,"=")"$)
	AddCode(CV, $"Dim v As String = BANanoShared.MvField(mt,2,"=")"$)
	AddCode(CV, $"If mElement <> Null Then mElement.SetAttr(k, v)"$)
	AddCode(CV, $"attributeList.put(k, v)"$)
	AddCode(CV, "Next")
	AddCode(CV, "End Sub")
	AddNewLine(CV)
	AddComment(CV, "sets the styles from the designer")
	AddCode(CV, "public Sub setStyles(varStyles As String)")
	AddCode(CV, $"Dim mItems As List = BANanoShared.StrParse(",", varStyles)"$)
	AddCode(CV, $"For Each mt As String In mItems"$)
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
	AddNewLine(CV)
	CV.append(GS.tostring)
	AddNewLine(CV)
	'
	Return CV.tostring
End Sub


private Sub AddNewLine(sbx As StringBuilder)
	sbx.Append(CRLF)
End Sub

private Sub AddComment(sbx As StringBuilder, xcode As String)
	sbx.Append("'" & xcode).Append(CRLF)
End Sub

private Sub AddCode(sbx As StringBuilder, xcode As String)
	sbx.Append(xcode).Append(CRLF)
End Sub


private Sub AddCodeInline(sbx As StringBuilder, xcode As String)
	sbx.Append(xcode)
End Sub
