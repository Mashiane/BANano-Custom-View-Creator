B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
'Custom BANano View class

#Event: click (event as BANanoEvent)

#DesignerProperty: Key: Text, DisplayName: Text, FieldType: String, DefaultValue: , Description: Text on the element
#DesignerProperty: Key: Classes, DisplayName: Classes, FieldType: String, DefaultValue: , Description: Classes added to the HTML tag.
#DesignerProperty: Key: Style, DisplayName: Style, FieldType: String, DefaultValue: , Description: Styles added to the HTML tag. Must be a json String.
#DesignerProperty: Key: Attributes, DisplayName: Attributes, FieldType: String, DefaultValue: , Description: Attributes added to the HTML tag. Must be a json String.
#DesignerProperty: Key: MarginBottom, DisplayName: MarginBottom, FieldType: String, DefaultValue:  , Description: 
#DesignerProperty: Key: MarginLeft, DisplayName: MarginLeft, FieldType: String, DefaultValue:  , Description: 
#DesignerProperty: Key: MarginRight, DisplayName: MarginRight, FieldType: String, DefaultValue:  , Description: 
#DesignerProperty: Key: MarginTop, DisplayName: MarginTop, FieldType: String, DefaultValue:  , Description: 
#DesignerProperty: Key: PaddingBottom, DisplayName: PaddingBottom, FieldType: String, DefaultValue:  , Description: 
#DesignerProperty: Key: PaddingLeft, DisplayName: PaddingLeft, FieldType: String, DefaultValue:  , Description: 
#DesignerProperty: Key: PaddingRight, DisplayName: PaddingRight, FieldType: String, DefaultValue:  , Description: 
#DesignerProperty: Key: PaddingTop, DisplayName: PaddingTop, FieldType: String, DefaultValue:  , Description: 

#DesignerProperty: Key: BadgePill, DisplayName: BadgePill, FieldType: Boolean, DefaultValue: False , Description: 
#DesignerProperty: Key: BadgeType, DisplayName: BadgeType, FieldType: String, DefaultValue:  , Description: , List: badge-primary|badge-secondary|badge-success|badge-danger|badge-warning|badge-info|badge-light|badge-dark

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
Private mTagName As String = "span"
Private mMarginBottom As String
Private mMarginLeft As String
Private mMarginRight As String
Private mMarginTop As String
Private mPaddingBottom As String
Private mPaddingLeft As String
Private mPaddingRight As String
Private mPaddingTop As String
Private mBadge As String = "badge"
Private mBadgePill As Boolean = False
Private mBadgeType As String = ""
End Sub

'initialize the custom view
Public Sub Initialize (CallBack As Object, Name As String, EventName As String)
mName = Name.ToLowerCase
mEventName = EventName.ToLowerCase
mCallBack = CallBack
classList.Initialize
styleList.Initialize
attributeList.Initialize
End Sub

'Create view in the designer
Public Sub DesignerCreateView (Target As BANanoElement, Props As Map)
mTarget = Target
If Props <> Null Then
mClasses = Props.Get("Classes")
mAttributes = Props.Get("Attributes")
mStyle = Props.Get("Style")
mText = Props.Get("Text")
mMarginBottom = Props.Get("MarginBottom")
mMarginLeft = Props.Get("MarginLeft")
mMarginRight = Props.Get("MarginRight")
mMarginTop = Props.Get("MarginTop")
mPaddingBottom = Props.Get("PaddingBottom")
mPaddingLeft = Props.Get("PaddingLeft")
mPaddingRight = Props.Get("PaddingRight")
mPaddingTop = Props.Get("PaddingTop")
mBadgePill = Props.Get("BadgePill")
mBadgeType = Props.Get("BadgeType")
End If

AddStyle("margin-bottom", mMarginBottom)
AddStyle("margin-left", mMarginLeft)
AddStyle("margin-right", mMarginRight)
AddStyle("margin-top", mMarginTop)
AddStyle("padding-bottom", mPaddingBottom)
AddStyle("padding-left", mPaddingLeft)
AddStyle("padding-right", mPaddingRight)
AddStyle("padding-top", mPaddingTop)
AddClass(mBadge)
AddClassOnCondition("badge-pill", mBadgePill, True)
AddClass(mBadgeType)
AddClass(mClasses)
setAttributes(mAttributes)
setStyles(mStyle)

'build and get the element
Dim strHTML As String = ToString
mElement = mTarget.Append(strHTML).Get("#" & mName)
'add events for the custom view, if any
mElement.HandleEvents("click", mCallBack, mEventName & "_click")

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
Dim rslt As String = $"<${mTagName} id="${mName}" ${iStructure}>${mText}</${mTagName}>"$
Return rslt
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
Dim mItems As List = BANanoShared.StrParse(" ", varClass)
For Each mt As String In mItems
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
Dim mItems As List = BANanoShared.StrParse(" ", varClass)
For Each mt As String In mItems
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
public Sub AddAttr(varProp As string, varValue As String)
If BANano.IsUndefined(varValue) Or BANano.IsNull(varValue) Then Return
If BANano.IsNumber(varValue) Then varValue = BANanoShared.CStr(varValue)
If mElement <> Null Then mElement.SetAttr(varProp, varValue)
attributeList.put(varProp, varValue)
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
Dim mItems As List = BANanoShared.StrParse(";", varAttributes)
For Each mt As String In mItems
Dim k As String = BANanoShared.MvField(mt,1,"=")
Dim v As String = BANanoShared.MvField(mt,2,"=")
If mElement <> Null Then mElement.SetAttr(k, v)
attributeList.put(k, v)
Next
End Sub

'sets the styles from the designer
public Sub setStyles(varStyles As String)
Dim mItems As List = BANanoShared.StrParse(",", varStyles)
For Each mt As String In mItems
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

public Sub setMarginBottom(varMarginBottom As String)
AddStyle("margin-bottom", varMarginBottom)
mMarginBottom = varMarginBottom
End Sub

public Sub getMarginBottom() As String
Return mMarginBottom
End Sub

public Sub setMarginLeft(varMarginLeft As String)
AddStyle("margin-left", varMarginLeft)
mMarginLeft = varMarginLeft
End Sub

public Sub getMarginLeft() As String
Return mMarginLeft
End Sub

public Sub setMarginRight(varMarginRight As String)
AddStyle("margin-right", varMarginRight)
mMarginRight = varMarginRight
End Sub

public Sub getMarginRight() As String
Return mMarginRight
End Sub

public Sub setMarginTop(varMarginTop As String)
AddStyle("margin-top", varMarginTop)
mMarginTop = varMarginTop
End Sub

public Sub getMarginTop() As String
Return mMarginTop
End Sub

public Sub setPaddingBottom(varPaddingBottom As String)
AddStyle("padding-bottom", varPaddingBottom)
mPaddingBottom = varPaddingBottom
End Sub

public Sub getPaddingBottom() As String
Return mPaddingBottom
End Sub

public Sub setPaddingLeft(varPaddingLeft As String)
AddStyle("padding-left", varPaddingLeft)
mPaddingLeft = varPaddingLeft
End Sub

public Sub getPaddingLeft() As String
Return mPaddingLeft
End Sub

public Sub setPaddingRight(varPaddingRight As String)
AddStyle("padding-right", varPaddingRight)
mPaddingRight = varPaddingRight
End Sub

public Sub getPaddingRight() As String
Return mPaddingRight
End Sub

public Sub setPaddingTop(varPaddingTop As String)
AddStyle("padding-top", varPaddingTop)
mPaddingTop = varPaddingTop
End Sub

public Sub getPaddingTop() As String
Return mPaddingTop
End Sub

public Sub setBadgePill(varBadgePill As Boolean)
AddClass(varBadgePill)
mBadgePill = varBadgePill
End Sub

public Sub getBadgePill() As Boolean
Return mBadgePill
End Sub

public Sub setBadgeType(varBadgeType As String)
AddClass(varBadgeType)
mBadgeType = varBadgeType
End Sub

public Sub getBadgeType() As String
Return mBadgeType
End Sub


