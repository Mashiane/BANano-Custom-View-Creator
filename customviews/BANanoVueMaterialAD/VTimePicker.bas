B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
#IgnoreWarnings:12
'Custom BANano View class

#Event: Input (argument As String)

#DesignerProperty: Key: OnInput, DisplayName: OnInput, FieldType: String, DefaultValue: , Description: Event arguments to be passed to the attribute.
#DesignerProperty: Key: Text, DisplayName: Text, FieldType: String, DefaultValue: , Description: Text on the element
#DesignerProperty: Key: Classes, DisplayName: Classes, FieldType: String, DefaultValue: , Description: Classes added to the HTML tag.
#DesignerProperty: Key: Style, DisplayName: Style, FieldType: String, DefaultValue: , Description: Styles added to the HTML tag. Must be a json String.
#DesignerProperty: Key: Attributes, DisplayName: Attributes, FieldType: String, DefaultValue: , Description: Attributes added to the HTML tag. Must be a json String.
#DesignerProperty: Key: AllowedHours, DisplayName: AllowedHours, FieldType: String, DefaultValue:  , Description: 
#DesignerProperty: Key: AllowedMinutes, DisplayName: AllowedMinutes, FieldType: String, DefaultValue:  , Description: 
#DesignerProperty: Key: AllowedSeconds, DisplayName: AllowedSeconds, FieldType: String, DefaultValue:  , Description: 
#DesignerProperty: Key: AmpmInTitle, DisplayName: AmpmInTitle, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: Color, DisplayName: Color, FieldType: String, DefaultValue:  , Description: 
#DesignerProperty: Key: Dark, DisplayName: Dark, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: Disabled, DisplayName: Disabled, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: Elevation, DisplayName: Elevation, FieldType: String, DefaultValue:  , Description: 
#DesignerProperty: Key: Flat, DisplayName: Flat, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: Format, DisplayName: Format, FieldType: String, DefaultValue: ampm , Description: 
#DesignerProperty: Key: FullWidth, DisplayName: FullWidth, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: HeaderColor, DisplayName: HeaderColor, FieldType: String, DefaultValue:  , Description: 
#DesignerProperty: Key: Key, DisplayName: Key, FieldType: String, DefaultValue:  , Description: key
#DesignerProperty: Key: Landscape, DisplayName: Landscape, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: Light, DisplayName: Light, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: Max, DisplayName: Max, FieldType: String, DefaultValue:  , Description: 
#DesignerProperty: Key: Min, DisplayName: Min, FieldType: String, DefaultValue:  , Description: 
#DesignerProperty: Key: NoTitle, DisplayName: NoTitle, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: ParentId, DisplayName: ParentId, FieldType: String, DefaultValue:  , Description: parent-id
#DesignerProperty: Key: Readonly, DisplayName: Readonly, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: Ref, DisplayName: Ref, FieldType: String, DefaultValue:  , Description: ref
#DesignerProperty: Key: Scrollable, DisplayName: Scrollable, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: UseSeconds, DisplayName: UseSeconds, FieldType: Boolean, DefaultValue: False , Description: 
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
#DesignerProperty: Key: Value, DisplayName: Value, FieldType: String, DefaultValue:  , Description: 
#DesignerProperty: Key: Width, DisplayName: Width, FieldType: String, DefaultValue: 290 , Description: 
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
Private mTagName As String = "v-time-picker"
Private sbText As StringBuilder
Public bindings As Map
Public methods As Map
Private eOnInput As String = ""
Private mAllowedHours As String = ""
Private mAllowedMinutes As String = ""
Private mAllowedSeconds As String = ""
Private mAmpmInTitle As Boolean = False
Private mColor As String = ""
Private mDark As Boolean = False
Private mDisabled As Boolean = False
Private mElevation As String = ""
Private mFlat As Boolean = False
Private mFormat As String = "ampm"
Private mFullWidth As Boolean = False
Private mHeaderColor As String = ""
Private mKey As String = ""
Private mLandscape As Boolean = False
Private mLight As Boolean = False
Private mMax As String = ""
Private mMin As String = ""
Private mNoTitle As Boolean = False
Private mParentId As String = ""
Private mReadonly As Boolean = False
Private mRef As String = ""
Private mScrollable As Boolean = False
Private mUseSeconds As Boolean = False
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
Private mValue As String = ""
Private mWidth As String = "290"
Private mBorderColor As String = ""
Private mBorderRadius As String = ""
Private mBorderStyle As String = ""
Private mBorderWidth As String = ""
Private mMarginBottom As String = ""
Private mMarginLeft As String = ""
Private mMarginRight As String = ""
Private mMarginTop As String = ""
Private mPaddingBottom As String = ""
Private mPaddingLeft As String = ""
Private mPaddingRight As String = ""
Private mPaddingTop As String = ""
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
eOnInput = Props.Get("OnInput")
mAllowedHours = Props.Get("AllowedHours")
mAllowedMinutes = Props.Get("AllowedMinutes")
mAllowedSeconds = Props.Get("AllowedSeconds")
mAmpmInTitle = Props.Get("AmpmInTitle")
mColor = Props.Get("Color")
mDark = Props.Get("Dark")
mDisabled = Props.Get("Disabled")
mElevation = Props.Get("Elevation")
mFlat = Props.Get("Flat")
mFormat = Props.Get("Format")
mFullWidth = Props.Get("FullWidth")
mHeaderColor = Props.Get("HeaderColor")
mKey = Props.Get("Key")
mLandscape = Props.Get("Landscape")
mLight = Props.Get("Light")
mMax = Props.Get("Max")
mMin = Props.Get("Min")
mNoTitle = Props.Get("NoTitle")
mParentId = Props.Get("ParentId")
mReadonly = Props.Get("Readonly")
mRef = Props.Get("Ref")
mScrollable = Props.Get("Scrollable")
mUseSeconds = Props.Get("UseSeconds")
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
mValue = Props.Get("Value")
mWidth = Props.Get("Width")
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

AddAttr("allowed-hours", mAllowedHours)
AddAttr("allowed-minutes", mAllowedMinutes)
AddAttr("allowed-seconds", mAllowedSeconds)
AddAttr("ampm-in-title", mAmpmInTitle)
AddAttr("color", mColor)
AddAttr("dark", mDark)
AddAttr("disabled", mDisabled)
AddAttr("elevation", mElevation)
AddAttr("flat", mFlat)
AddAttr("format", mFormat)
AddAttr("full-width", mFullWidth)
AddAttr("header-color", mHeaderColor)
AddAttr("key", mKey)
AddAttr("landscape", mLandscape)
AddAttr("light", mLight)
AddAttr("max", mMax)
AddAttr("min", mMin)
AddAttr("no-title", mNoTitle)
AddAttr("parent-id", mParentId)
AddAttr("readonly", mReadonly)
AddAttr("ref", mRef)
AddAttr("scrollable", mScrollable)
AddAttr("use-seconds", mUseSeconds)
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
AddAttr("value", mValue)
AddAttr("width", mWidth)
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
'This activates Input the event exists on the module
SetOnInput

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

public Sub setAllowedHours(varAllowedHours As String)
AddAttr("allowed-hours", varAllowedHours)
mAllowedHours = varAllowedHours
End Sub

public Sub getAllowedHours() As String
Return mAllowedHours
End Sub

public Sub setAllowedMinutes(varAllowedMinutes As String)
AddAttr("allowed-minutes", varAllowedMinutes)
mAllowedMinutes = varAllowedMinutes
End Sub

public Sub getAllowedMinutes() As String
Return mAllowedMinutes
End Sub

public Sub setAllowedSeconds(varAllowedSeconds As String)
AddAttr("allowed-seconds", varAllowedSeconds)
mAllowedSeconds = varAllowedSeconds
End Sub

public Sub getAllowedSeconds() As String
Return mAllowedSeconds
End Sub

public Sub setAmpmInTitle(varAmpmInTitle As Boolean)
AddAttr("ampm-in-title", varAmpmInTitle)
mAmpmInTitle = varAmpmInTitle
End Sub

public Sub getAmpmInTitle() As Boolean
Return mAmpmInTitle
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

public Sub setDisabled(varDisabled As Boolean)
AddAttr("disabled", varDisabled)
mDisabled = varDisabled
End Sub

public Sub getDisabled() As Boolean
Return mDisabled
End Sub

public Sub setElevation(varElevation As String)
AddAttr("elevation", varElevation)
mElevation = varElevation
End Sub

public Sub getElevation() As String
Return mElevation
End Sub

public Sub setFlat(varFlat As Boolean)
AddAttr("flat", varFlat)
mFlat = varFlat
End Sub

public Sub getFlat() As Boolean
Return mFlat
End Sub

public Sub setFormat(varFormat As String)
AddAttr("format", varFormat)
mFormat = varFormat
End Sub

public Sub getFormat() As String
Return mFormat
End Sub

public Sub setFullWidth(varFullWidth As Boolean)
AddAttr("full-width", varFullWidth)
mFullWidth = varFullWidth
End Sub

public Sub getFullWidth() As Boolean
Return mFullWidth
End Sub

public Sub setHeaderColor(varHeaderColor As String)
AddAttr("header-color", varHeaderColor)
mHeaderColor = varHeaderColor
End Sub

public Sub getHeaderColor() As String
Return mHeaderColor
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

public Sub setLandscape(varLandscape As Boolean)
AddAttr("landscape", varLandscape)
mLandscape = varLandscape
End Sub

public Sub getLandscape() As Boolean
Return mLandscape
End Sub

public Sub setLight(varLight As Boolean)
AddAttr("light", varLight)
mLight = varLight
End Sub

public Sub getLight() As Boolean
Return mLight
End Sub

public Sub setMax(varMax As String)
AddAttr("max", varMax)
mMax = varMax
End Sub

public Sub getMax() As String
Return mMax
End Sub

public Sub setMin(varMin As String)
AddAttr("min", varMin)
mMin = varMin
End Sub

public Sub getMin() As String
Return mMin
End Sub

public Sub setNoTitle(varNoTitle As Boolean)
AddAttr("no-title", varNoTitle)
mNoTitle = varNoTitle
End Sub

public Sub getNoTitle() As Boolean
Return mNoTitle
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

public Sub setReadonly(varReadonly As Boolean)
AddAttr("readonly", varReadonly)
mReadonly = varReadonly
End Sub

public Sub getReadonly() As Boolean
Return mReadonly
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

public Sub setScrollable(varScrollable As Boolean)
AddAttr("scrollable", varScrollable)
mScrollable = varScrollable
End Sub

public Sub getScrollable() As Boolean
Return mScrollable
End Sub

public Sub setUseSeconds(varUseSeconds As Boolean)
AddAttr("use-seconds", varUseSeconds)
mUseSeconds = varUseSeconds
End Sub

public Sub getUseSeconds() As Boolean
Return mUseSeconds
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

public Sub setValue(varValue As String)
AddAttr("value", varValue)
mValue = varValue
End Sub

public Sub getValue() As String
Return mValue
End Sub

public Sub setWidth(varWidth As String)
AddAttr("width", varWidth)
mWidth = varWidth
End Sub

public Sub getWidth() As String
Return mWidth
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

'set on Input event, updates the master events records
Sub SetOnInput()
Dim sName As String = $"${mEventName}_Input"$
sName = sName.tolowercase
If SubExists(mCallBack, sName) = False Then Return
If BANano.IsUndefined(eOnInput) Or BANano.IsNull(eOnInput) Then eOnInput = ""
Dim sCode As String = $"${sName}(${eOnInput})"$
AddAttr("v-on:input", sCode)
'arguments for the event
Dim argument As String 'ignore
Dim cb As BANanoObject = BANano.CallBack(mCallBack, sName, Array(argument As String))
methods.Put(sName, cb)
End Sub

Sub SetOnInputE(sInput As String)
eOnInput = sInput
End Sub

