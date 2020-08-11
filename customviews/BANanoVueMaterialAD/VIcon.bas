B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
#IgnoreWarnings:12
'Custom BANano View class


#DesignerProperty: Key: Text, DisplayName: Text, FieldType: String, DefaultValue: , Description: Text on the element
#DesignerProperty: Key: Classes, DisplayName: Classes, FieldType: String, DefaultValue: , Description: Classes added to the HTML tag.
#DesignerProperty: Key: Style, DisplayName: Style, FieldType: String, DefaultValue: , Description: Styles added to the HTML tag. Must be a json String.
#DesignerProperty: Key: Attributes, DisplayName: Attributes, FieldType: String, DefaultValue: , Description: Attributes added to the HTML tag. Must be a json String.
#DesignerProperty: Key: Color, DisplayName: Color, FieldType: String, DefaultValue:  , Description: 
#DesignerProperty: Key: Dark, DisplayName: Dark, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: Dense, DisplayName: Dense, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: Disabled, DisplayName: Disabled, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: Key, DisplayName: Key, FieldType: String, DefaultValue:  , Description: key
#DesignerProperty: Key: Large, DisplayName: Large, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: Left, DisplayName: Left, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: Light, DisplayName: Light, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: ParentId, DisplayName: ParentId, FieldType: String, DefaultValue:  , Description: parent-id
#DesignerProperty: Key: Ref, DisplayName: Ref, FieldType: String, DefaultValue:  , Description: ref
#DesignerProperty: Key: Right, DisplayName: Right, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: Size, DisplayName: Size, FieldType: String, DefaultValue:  , Description: 
#DesignerProperty: Key: Small, DisplayName: Small, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: Tag, DisplayName: Tag, FieldType: String, DefaultValue: i , Description: 
#DesignerProperty: Key: VBindClass, DisplayName: VBindClass, FieldType: String, DefaultValue:  , Description: v-bind:class
#DesignerProperty: Key: VBindStyle, DisplayName: VBindStyle, FieldType: String, DefaultValue:  , Description: v-bind:style
#DesignerProperty: Key: VElse, DisplayName: VElse, FieldType: String, DefaultValue:  , Description: v-else
#DesignerProperty: Key: VElseIf, DisplayName: VElseIf, FieldType: String, DefaultValue:  , Description: v-else-if
#DesignerProperty: Key: VFor, DisplayName: VFor, FieldType: String, DefaultValue:  , Description: v-for
#DesignerProperty: Key: VHtml, DisplayName: VHtml, FieldType: String, DefaultValue:  , Description: v-html
#DesignerProperty: Key: VIf, DisplayName: VIf, FieldType: String, DefaultValue:  , Description: v-if
#DesignerProperty: Key: VModel, DisplayName: VModel, FieldType: String, DefaultValue:  , Description: v-model
#DesignerProperty: Key: VOn, DisplayName: VOn, FieldType: String, DefaultValue:  , Description: v-on
#DesignerProperty: Key: VShow, DisplayName: VShow, FieldType: String, DefaultValue:  , Description: v-show
#DesignerProperty: Key: VText, DisplayName: VText, FieldType: String, DefaultValue:  , Description: v-text
#DesignerProperty: Key: XLarge, DisplayName: XLarge, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: XSmall, DisplayName: XSmall, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: BorderColor, DisplayName: BorderColor, FieldType: String, DefaultValue:  , Description: null, List: amber|black|blue|blue-grey|brown|cyan|deep-orange|deep-purple|green|grey|indigo|light-blue|light-green|lime|orange|pink|purple|red|teal|transparent|white|yellow|primary|secondary|accent|error|info|success|warning|none
#DesignerProperty: Key: BorderRadius, DisplayName: BorderRadius, FieldType: String, DefaultValue:  , Description: null
#DesignerProperty: Key: BorderStyle, DisplayName: BorderStyle, FieldType: String, DefaultValue:  , Description: null, List: dashed|dotted|double|groove|hidden|inset|none|outset|ridge|solid
#DesignerProperty: Key: BorderWidth, DisplayName: BorderWidth, FieldType: String, DefaultValue:  , Description: null
#DesignerProperty: Key: MarginBottom, DisplayName: MarginBottom, FieldType: String, DefaultValue:  , Description: null
#DesignerProperty: Key: MarginLeft, DisplayName: MarginLeft, FieldType: String, DefaultValue:  , Description: null
#DesignerProperty: Key: MarginRight, DisplayName: MarginRight, FieldType: String, DefaultValue:  , Description: null
#DesignerProperty: Key: MarginTop, DisplayName: MarginTop, FieldType: String, DefaultValue:  , Description: null
#DesignerProperty: Key: PaddingBottom, DisplayName: PaddingBottom, FieldType: String, DefaultValue:  , Description: null
#DesignerProperty: Key: PaddingLeft, DisplayName: PaddingLeft, FieldType: String, DefaultValue:  , Description: null
#DesignerProperty: Key: PaddingRight, DisplayName: PaddingRight, FieldType: String, DefaultValue:  , Description: null
#DesignerProperty: Key: PaddingTop, DisplayName: PaddingTop, FieldType: String, DefaultValue:  , Description: null

Sub Class_Globals
Private BANano As BANano 'ignore
Private mName As String 'ignore
Private mEventName As String 'ignore
Private mCallBack As Object 'ignore
Private mTarget As BANanoElement 'ignore
Private mElement As BANanoElement 'ignore
Private mClasses As String = ""
Private mStyle As String = ""
Private mAttributes As String = ""
Private mText As String = ""
Private classList As Map
Private styleList As Map
Private attributeList As Map
Private mTagName As String = "v-icon"
Private sbText As StringBuilder
Public bindings As Map
Public methods As Map
Private mColor As String = ""
Private mDark As Boolean = False
Private mDense As Boolean = False
Private mDisabled As Boolean = False
Private mKey As String = ""
Private mLarge As Boolean = False
Private mLeft As Boolean = False
Private mLight As Boolean = False
Private mParentId As String = ""
Private mRef As String = ""
Private mRight As Boolean = False
Private mSize As String = ""
Private mSmall As Boolean = False
Private mTag As String = "i"
Private mVBindClass As String = ""
Private mVBindStyle As String = ""
Private mVElse As String = ""
Private mVElseIf As String = ""
Private mVFor As String = ""
Private mVHtml As String = ""
Private mVIf As String = ""
Private mVModel As String = ""
Private mVOn As String = ""
Private mVShow As String = ""
Private mVText As String = ""
Private mXLarge As Boolean = False
Private mXSmall As Boolean = False
Private mBorderColor As String
Private mBorderRadius As String
Private mBorderStyle As String
Private mBorderWidth As String
Private mMarginBottom As String
Private mMarginLeft As String
Private mMarginRight As String
Private mMarginTop As String
Private mPaddingBottom As String
Private mPaddingLeft As String
Private mPaddingRight As String
Private mPaddingTop As String
End Sub

'initialize the custom view
Public Sub Initialize (CallBack As Object, Name As String, EventName As String)
mName = Name.ToLowerCase
mEventName = EventName.ToLowerCase
mCallBack = CallBack
classList.Initialize
styleList.Initialize
attributeList.Initialize
sbText.Initialize
bindings.Initialize
methods.Initialize
End Sub

'Create view in the designer
Public Sub DesignerCreateView (Target As BANanoElement, Props As Map)
mTarget = Target
If Props <> Null Then
mClasses = Props.Get("Classes")
mAttributes = Props.Get("Attributes")
mStyle = Props.Get("Style")
mText = Props.Get("Text")
mColor = Props.Get("Color")
mDark = Props.Get("Dark")
mDense = Props.Get("Dense")
mDisabled = Props.Get("Disabled")
mKey = Props.Get("Key")
mLarge = Props.Get("Large")
mLeft = Props.Get("Left")
mLight = Props.Get("Light")
mParentId = Props.Get("ParentId")
mRef = Props.Get("Ref")
mRight = Props.Get("Right")
mSize = Props.Get("Size")
mSmall = Props.Get("Small")
mTag = Props.Get("Tag")
mVBindClass = Props.Get("VBindClass")
mVBindStyle = Props.Get("VBindStyle")
mVElse = Props.Get("VElse")
mVElseIf = Props.Get("VElseIf")
mVFor = Props.Get("VFor")
mVHtml = Props.Get("VHtml")
mVIf = Props.Get("VIf")
mVModel = Props.Get("VModel")
mVOn = Props.Get("VOn")
mVShow = Props.Get("VShow")
mVText = Props.Get("VText")
mXLarge = Props.Get("XLarge")
mXSmall = Props.Get("XSmall")
mBorderColor = Props.Get("BorderColor")
mBorderRadius = Props.Get("BorderRadius")
mBorderStyle = Props.Get("BorderStyle")
mBorderWidth = Props.Get("BorderWidth")
mMarginBottom = Props.Get("MarginBottom")
mMarginLeft = Props.Get("MarginLeft")
mMarginRight = Props.Get("MarginRight")
mMarginTop = Props.Get("MarginTop")
mPaddingBottom = Props.Get("PaddingBottom")
mPaddingLeft = Props.Get("PaddingLeft")
mPaddingRight = Props.Get("PaddingRight")
mPaddingTop = Props.Get("PaddingTop")
End If

AddAttr("color", mColor)
AddAttr("dark", mDark)
AddAttr("dense", mDense)
AddAttr("disabled", mDisabled)
AddAttr("key", mKey)
AddAttr("large", mLarge)
AddAttr("left", mLeft)
AddAttr("light", mLight)
AddAttr("parent-id", mParentId)
AddAttr("ref", mRef)
AddAttr("right", mRight)
AddAttr("size", mSize)
AddAttr("small", mSmall)
AddAttr("tag", mTag)
AddAttr("v-bind:class", mVBindClass)
AddAttr("v-bind:style", mVBindStyle)
AddAttr("v-else", mVElse)
AddAttr("v-else-if", mVElseIf)
AddAttr("v-for", mVFor)
AddAttr("v-html", mVHtml)
AddAttr("v-if", mVIf)
AddAttr("v-model", mVModel)
AddAttr("v-on", mVOn)
AddAttr("v-show", mVShow)
AddAttr("v-text", mVText)
AddAttr("x-large", mXLarge)
AddAttr("x-small", mXSmall)
AddStyle("border-color", mBorderColor)
AddStyle("border-radius", mBorderRadius)
AddStyle("border-style", mBorderStyle)
AddStyle("border-width", mBorderWidth)
AddStyle("margin-bottom", mMarginBottom)
AddStyle("margin-left", mMarginLeft)
AddStyle("margin-right", mMarginRight)
AddStyle("margin-top", mMarginTop)
AddStyle("padding-bottom", mPaddingBottom)
AddStyle("padding-left", mPaddingLeft)
AddStyle("padding-right", mPaddingRight)
AddStyle("padding-top", mPaddingTop)
AddClass(mClasses)
setAttributes(mAttributes)
setStyles(mStyle)

'build and get the element
Dim strHTML As String = ToString
mElement = mTarget.Append(strHTML).Get("#" & mName)
'add events for the custom view, if any

End Sub

'return the generated html
Sub ToString As String
'build the 'class' attribute
Dim className As String = BANanoShared.JoinMapKeys(classList, " ")
AddAttr("class", className)
'build the 'style' attribute
Dim styleName As String = BANanoShared.BuildStyle(styleList)
AddAttr("style", styleName)
'build element internal structure
Dim iStructure As String = BANanoShared.BuildAttributes(attributeList)
Dim rslt As String = $"<${mTagName} id="${mName}" ${iStructure}>${mText}${sbText.ToString}</${mTagName}>"$
Return rslt
End Sub

'bind an attribute
Sub SetVBind(prop As String, value As String)
prop = prop.ToLowerCase
value = value.ToLowerCase
prop = $"v-bind:${prop}"$
AddAttr(prop,value)
bindings.Put(value, Null)
End Sub

'add component to app, this binds events and states
Sub AddToApp(vap As VueApp)
'apply the binding for the control
For Each k As String In bindings.Keys
Dim v As String = bindings.Get(k)
vap.SetData(k, v)
Next
'apply the events
For Each k As String In methods.Keys
Dim cb As BANanoObject = methods.Get(k)
vap.SetCallBack(k, cb)
Next
End Sub

'add component to another, this binds events and states
Sub AddToComponent(ve As VMElement)
'apply the binding for the control
For Each k As String In bindings.Keys
Dim v As String = bindings.Get(k)
ve.SetData(k, v)
Next
'apply the events
For Each k As String In methods.Keys
Dim cb As BANanoObject = methods.Get(k)
ve.SetCallBack(k, cb)
Next
End Sub

'add a break
Sub AddBR
sbText.Append("<br>")
End Sub

'add a horizontal rule
Sub AddHR
sbText.Append("<hr>")
End Sub

'add an element to the text
Sub AddElement(elID As String, tag As String, props As Map, styleProps As Map, classNames As List, loose As List, Text As String)
elID = elID.tolowercase
elID = elID.Replace("#","")
Dim elIT As VHTML
elIT.Initialize(mCallBack, elID, elID)
elIT.SetText(Text)
elIT.SetTagName(tag)
If loose <> Null Then
For Each k As String In loose
elIT.SetAttr(k, True)
Next
End If
If props <> Null Then
For Each k As String In props.Keys
Dim v As String = props.Get(k)
elIT.SetAttr(k, v)
Next
End If
If styleProps <> Null Then
For Each k As String In styleProps.Keys
Dim v As String = styleProps.Get(k)
elIT.SetAttr(k, v)
Next
End If
If classNames <> Null Then
elIT.AddClass(classNames)
End If
'convert to string
Dim sElement As String = elIT.tostring
sbText.Append(sElement)
End Sub

'returns the BANanoElement
public Sub getElement() As BANanoElement
Return mElement
End Sub

'returns the tag id
public Sub getID() As String
Return mName
End Sub

'add the element to the parent
public Sub AddToParent(targetID As String)
mTarget = BANano.GetElement("#" & targetID.ToLowerCase)
DesignerCreateView(mTarget, Null)
End Sub

'remove the component
public Sub Remove()
mElement.Remove
BANano.SetMeToNull
End Sub

'trigger an event
public Sub Trigger(event As String, params() As String)
If mElement <> Null Then
mElement.Trigger(event, params)
End If
End Sub

'add a class
public Sub AddClass(varClass As String)
If BANano.IsUndefined(varClass) Or BANano.IsNull(varClass) Then Return
If BANano.IsNumber(varClass) Then varClass = BANanoShared.CStr(varClass)
varClass = varClass.trim
if varClass = "" Then Return
If mElement <> Null Then mElement.AddClass(varClass)
Dim mxItems As List = BANanoShared.StrParse(" ", varClass)
For Each mt As String In mxItems
classList.put(mt, mt)
Next
End Sub

'add a class on condition
public Sub AddClassOnCondition(varClass As String, varCondition As Boolean, varShouldBe As boolean)
If BANano.IsUndefined(varCondition) Or BANano.IsNull(varCondition) Then Return
if varShouldBe <> varCondition Then Return
If BANano.IsUndefined(varClass) Or BANano.IsNull(varClass) Then Return
If BANano.IsNumber(varClass) Then varClass = BANanoShared.CStr(varClass)
varClass = varClass.trim
if varClass = "" Then Return
If mElement <> Null Then mElement.AddClass(varClass)
Dim mxItems As List = BANanoShared.StrParse(" ", varClass)
For Each mt As String In mxItems
classList.put(mt, mt)
Next
End Sub

'add a style
public Sub AddStyle(varProp As string, varStyle As String)
If BANano.IsUndefined(varStyle) Or BANano.IsNull(varStyle) Then Return
If BANano.IsNumber(varStyle) Then varStyle = BANanoShared.CStr(varStyle)
If mElement <> Null Then
Dim aStyle As Map = CreateMap()
aStyle.put(varProp, varStyle)
Dim sStyle As String = BANano.ToJSON(aStyle)
mElement.SetStyle(sStyle)
End If
styleList.put(varProp, varStyle)
End Sub

'add an attribute
Public Sub AddAttr(varProp As String, varValue As String) 
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
If varValue.StartsWith("$") Then 
attributeList.put(varProp, varValue) 
If mElement <> Null Then mElement.SetAttr(varProp, varValue) 
Else 
Dim rname As String = BANanoShared.MidString2(varValue, 2) 
If rname.Contains(".") = False Then bindings.Put(rname, Null) 
attributeList.put($":${varProp}"$, rname) 
If mElement <> Null Then mElement.SetAttr($":${varProp}"$, rname) 
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
End Sub

'returns the class names
Public Sub getClasses() As String
Dim sbClass As StringBuilder
sbClass.Initialize
For each k As String in classList.Keys
sbClass.Append(k).Append(" ")
Next
mClasses = sbClass.ToString
Return mClasses
End Sub

'set the style use a valid JSON string with {}
public Sub setStyle(varStyle As String)
If mElement <> Null Then
mElement.SetStyle(varStyle)
End If
Dim mres as Map = BANano.FromJSON(varStyle)
For each k As String in mres.Keys
Dim v As String = mres.Get(k)
styleList.put(k, v)
Next
End Sub

'returns the style as JSON
public Sub getStyle() As String
Dim sbStyle As StringBuilder
sbStyle.Initialize
sbStyle.Append("{")
For each k As String in styleList.Keys
Dim v As String = styleList.Get(k)
sbStyle.Append(k).Append(":").Append(v).Append(",")
Next
sbStyle.Append("}")
mStyle = sbStyle.ToString
Return mStyle
End Sub

'sets the attributes
public Sub setAttributes(varAttributes As String)
Dim mxItems As List = BANanoShared.StrParse(";", varAttributes)
For Each mt As String In mxItems
Dim k As String = BANanoShared.MvField(mt,1,"=")
Dim v As String = BANanoShared.MvField(mt,2,"=")
If mElement <> Null Then mElement.SetAttr(k, v)
attributeList.put(k, v)
Next
End Sub

'sets the styles from the designer
public Sub setStyles(varStyles As String)
Dim mxItems As List = BANanoShared.StrParse(",", varStyles)
For Each mt As String In mxItems
Dim k As String = BANanoShared.MvField(mt,1,":")
Dim v As String = BANanoShared.MvField(mt,2,":")
AddStyle(k, v)
Next
End Sub

'returns the attributes
public Sub getAttributes() As String
Dim sbAttr As StringBuilder
sbAttr.Initialize
For each k As String in attributeList.Keys
Dim v As String = attributeList.Get(k)
sbAttr.Append(k).Append("=").Append(v).Append(";")
Next
mAttributes = sbAttr.ToString
Return mAttributes
End Sub

'sets the text
public Sub setText(varText As String)
If mElement <> Null Then
mElement.SetHTML(BANano.SF(varText))
End If
mText = varText
End Sub

'returns the text
public Sub getText() As String
Return mText
End Sub

public Sub setColor(varColor As String)
AddAttr("color", varColor)
mColor = varColor
End Sub

public Sub getColor() As String
Return mColor
End Sub

public Sub setDark(varDark As Boolean)
AddAttr("dark", varDark)
mDark = varDark
End Sub

public Sub getDark() As Boolean
Return mDark
End Sub

public Sub setDense(varDense As Boolean)
AddAttr("dense", varDense)
mDense = varDense
End Sub

public Sub getDense() As Boolean
Return mDense
End Sub

public Sub setDisabled(varDisabled As Boolean)
AddAttr("disabled", varDisabled)
mDisabled = varDisabled
End Sub

public Sub getDisabled() As Boolean
Return mDisabled
End Sub

'set key
public Sub setKey(varKey As String)
AddAttr("key", varKey)
mKey = varKey
End Sub

'get key
public Sub getKey() As String
Return mKey
End Sub

public Sub setLarge(varLarge As Boolean)
AddAttr("large", varLarge)
mLarge = varLarge
End Sub

public Sub getLarge() As Boolean
Return mLarge
End Sub

public Sub setLeft(varLeft As Boolean)
AddAttr("left", varLeft)
mLeft = varLeft
End Sub

public Sub getLeft() As Boolean
Return mLeft
End Sub

public Sub setLight(varLight As Boolean)
AddAttr("light", varLight)
mLight = varLight
End Sub

public Sub getLight() As Boolean
Return mLight
End Sub

'set parent-id
public Sub setParentId(varParentId As String)
AddAttr("parent-id", varParentId)
mParentId = varParentId
End Sub

'get parent-id
public Sub getParentId() As String
Return mParentId
End Sub

'set ref
public Sub setRef(varRef As String)
AddAttr("ref", varRef)
mRef = varRef
End Sub

'get ref
public Sub getRef() As String
Return mRef
End Sub

public Sub setRight(varRight As Boolean)
AddAttr("right", varRight)
mRight = varRight
End Sub

public Sub getRight() As Boolean
Return mRight
End Sub

public Sub setSize(varSize As String)
AddAttr("size", varSize)
mSize = varSize
End Sub

public Sub getSize() As String
Return mSize
End Sub

public Sub setSmall(varSmall As Boolean)
AddAttr("small", varSmall)
mSmall = varSmall
End Sub

public Sub getSmall() As Boolean
Return mSmall
End Sub

public Sub setTag(varTag As String)
AddAttr("tag", varTag)
mTag = varTag
End Sub

public Sub getTag() As String
Return mTag
End Sub

'set v-bind:class
public Sub setVBindClass(varVBindClass As String)
AddAttr("v-bind:class", varVBindClass)
mVBindClass = varVBindClass
End Sub

'get v-bind:class
public Sub getVBindClass() As String
Return mVBindClass
End Sub

'set v-bind:style
public Sub setVBindStyle(varVBindStyle As String)
AddAttr("v-bind:style", varVBindStyle)
mVBindStyle = varVBindStyle
End Sub

'get v-bind:style
public Sub getVBindStyle() As String
Return mVBindStyle
End Sub

'set v-else
public Sub setVElse(varVElse As String)
AddAttr("v-else", varVElse)
mVElse = varVElse
End Sub

'get v-else
public Sub getVElse() As String
Return mVElse
End Sub

'set v-else-if
public Sub setVElseIf(varVElseIf As String)
AddAttr("v-else-if", varVElseIf)
mVElseIf = varVElseIf
End Sub

'get v-else-if
public Sub getVElseIf() As String
Return mVElseIf
End Sub

'set v-for
public Sub setVFor(varVFor As String)
AddAttr("v-for", varVFor)
mVFor = varVFor
End Sub

'get v-for
public Sub getVFor() As String
Return mVFor
End Sub

'set v-html
public Sub setVHtml(varVHtml As String)
AddAttr("v-html", varVHtml)
mVHtml = varVHtml
End Sub

'get v-html
public Sub getVHtml() As String
Return mVHtml
End Sub

'set v-if
public Sub setVIf(varVIf As String)
AddAttr("v-if", varVIf)
mVIf = varVIf
End Sub

'get v-if
public Sub getVIf() As String
Return mVIf
End Sub

'set v-model
public Sub setVModel(varVModel As String)
AddAttr("v-model", varVModel)
mVModel = varVModel
End Sub

'get v-model
public Sub getVModel() As String
Return mVModel
End Sub

'set v-on
public Sub setVOn(varVOn As String)
AddAttr("v-on", varVOn)
mVOn = varVOn
End Sub

'get v-on
public Sub getVOn() As String
Return mVOn
End Sub

'set v-show
public Sub setVShow(varVShow As String)
AddAttr("v-show", varVShow)
mVShow = varVShow
End Sub

'get v-show
public Sub getVShow() As String
Return mVShow
End Sub

'set v-text
public Sub setVText(varVText As String)
AddAttr("v-text", varVText)
mVText = varVText
End Sub

'get v-text
public Sub getVText() As String
Return mVText
End Sub

public Sub setXLarge(varXLarge As Boolean)
AddAttr("x-large", varXLarge)
mXLarge = varXLarge
End Sub

public Sub getXLarge() As Boolean
Return mXLarge
End Sub

public Sub setXSmall(varXSmall As Boolean)
AddAttr("x-small", varXSmall)
mXSmall = varXSmall
End Sub

public Sub getXSmall() As Boolean
Return mXSmall
End Sub

'set null
public Sub setBorderColor(varBorderColor As String)
AddStyle("border-color", varBorderColor)
mBorderColor = varBorderColor
End Sub

'get null
public Sub getBorderColor() As String
Return mBorderColor
End Sub

'set null
public Sub setBorderRadius(varBorderRadius As String)
AddStyle("border-radius", varBorderRadius)
mBorderRadius = varBorderRadius
End Sub

'get null
public Sub getBorderRadius() As String
Return mBorderRadius
End Sub

'set null
public Sub setBorderStyle(varBorderStyle As String)
AddStyle("border-style", varBorderStyle)
mBorderStyle = varBorderStyle
End Sub

'get null
public Sub getBorderStyle() As String
Return mBorderStyle
End Sub

'set null
public Sub setBorderWidth(varBorderWidth As String)
AddStyle("border-width", varBorderWidth)
mBorderWidth = varBorderWidth
End Sub

'get null
public Sub getBorderWidth() As String
Return mBorderWidth
End Sub

'set null
public Sub setMarginBottom(varMarginBottom As String)
AddStyle("margin-bottom", varMarginBottom)
mMarginBottom = varMarginBottom
End Sub

'get null
public Sub getMarginBottom() As String
Return mMarginBottom
End Sub

'set null
public Sub setMarginLeft(varMarginLeft As String)
AddStyle("margin-left", varMarginLeft)
mMarginLeft = varMarginLeft
End Sub

'get null
public Sub getMarginLeft() As String
Return mMarginLeft
End Sub

'set null
public Sub setMarginRight(varMarginRight As String)
AddStyle("margin-right", varMarginRight)
mMarginRight = varMarginRight
End Sub

'get null
public Sub getMarginRight() As String
Return mMarginRight
End Sub

'set null
public Sub setMarginTop(varMarginTop As String)
AddStyle("margin-top", varMarginTop)
mMarginTop = varMarginTop
End Sub

'get null
public Sub getMarginTop() As String
Return mMarginTop
End Sub

'set null
public Sub setPaddingBottom(varPaddingBottom As String)
AddStyle("padding-bottom", varPaddingBottom)
mPaddingBottom = varPaddingBottom
End Sub

'get null
public Sub getPaddingBottom() As String
Return mPaddingBottom
End Sub

'set null
public Sub setPaddingLeft(varPaddingLeft As String)
AddStyle("padding-left", varPaddingLeft)
mPaddingLeft = varPaddingLeft
End Sub

'get null
public Sub getPaddingLeft() As String
Return mPaddingLeft
End Sub

'set null
public Sub setPaddingRight(varPaddingRight As String)
AddStyle("padding-right", varPaddingRight)
mPaddingRight = varPaddingRight
End Sub

'get null
public Sub getPaddingRight() As String
Return mPaddingRight
End Sub

'set null
public Sub setPaddingTop(varPaddingTop As String)
AddStyle("padding-top", varPaddingTop)
mPaddingTop = varPaddingTop
End Sub

'get null
public Sub getPaddingTop() As String
Return mPaddingTop
End Sub


'add a child component
Sub AddChild(child As String)
sbText.Append(child)
End Sub

