B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.1
@EndOfDesignText@
'Static code module
#IgnoreWarnings:12, 15
Sub Process_Globals
	Private BANano As BANano  'ignore
	Public vm As BANanoVM
	Private vue As BANanoVue   'ignore
End Sub

Sub Init
	'initialize the page
	vm.Initialize(Me, Main.appname)
	vue = vm.vue
	BuildNavBar
	BuildNavDrawer
	AddPages
	AddContent
	BuildBottomNav
	BuildFooter
	'
	vm.ux
	'show the login page
	pgProjects.Show
End Sub


'build the footer of the page
Sub BuildFooter
	'*copy code after this line
	vm.Footer.SHow
	vm.Footer.SetFixed(True)
	vm.Footer.SetColor("indigo")
	vm.footer.Container.SetTag("div")
	vm.footer.Container.AddRows(1).AddColumns12
	vm.Footer.Container.SetAttrRC(1, 0, "align", "center")
	'
	vm.footer.AddMadeWithLove(1, 1, "with B4J, BANano and BANanoVueDesigner by", "TheMash", "mbanga.anele@gmail.com")
End Sub

'build the bottom nav bar
Sub BuildBottomNav
	'*copy code after this line
	
End Sub

'build the navigation bar
Sub BuildNavBar
	'*copy code after this line
	'vm.NavBar.AddHamburger
	'vm.NavBar.Hamburger.SetVisible(False)
	'add a logo
	vm.NavBar.Logo.SetBorderRadius("50%")
	vm.NavBar.Logo.SetBorderWidth("1px")
	vm.NavBar.Logo.SetBorderColor("black")
	vm.NavBar.Logo.SetBorderStyle("solid")
	vm.NavBar.Logo.SetSize("46px","46px")
	vm.NavBar.Logo.SetOnClick(Me, "logo_click")
	vm.NavBar.AddLogo("./assets/ninja.jpg")
	vm.NavBar.Logo.SetAlt("BANanoNinja")
	vm.NavBar.Logo.Show
	vm.NavBar.Title.AddClass("white--text")
	vm.NavBar.Title.SetOnClick(Me, "title_click")
	vm.NavBar.AddTitle("BANano Custom View Creator","")
	vm.navbar.SubHeading.AddClass("white--text")
	vm.NavBar.AddSubHeading1("1.00")
	vm.NavBar.AddSpacer
	vm.NavBar.SetFixed(True)
	vm.NavBar.SetVisible(True)
	vm.NavBar.SetColor("indigo")
	vm.navbar.Progress.SetColor(vm.COLOR_ORANGE)
	'
	Dim lblBy As VMLabel
	lblBy.Initialize(vue, "doneby").SetText("Created by TheMash").AddClass("mx-2 white--text")
	vm.navbar.AddComponent("doneby", lblBy.tostring)
	'
	'Add Projects to navbar
	vm.NavBar.AddButton1("navProjects", "", "Projects", "Maintain projects", "")
	vm.NavBar.AddButton1("navComponents", "", "Components", "Maintain components", "")
End Sub

'build the nav drawer
Sub BuildNavDrawer
	'*copy code after this line
	'vm.Drawer.Setwidth("400")
	'vm.Drawer.Setabsolute(True)
	'vm.Drawer.Setvisible(True)
	'
	'Add Projects to drawer
	'vm.Drawer.AddIcon1("pageProjects", "", "", "Projects", "Maintain projects")
	'vm.Drawer.AddDivider1(False)
	'vm.Drawer.Hide
	'remove the drawer
	BANano.GetElement("#drawer").Remove
End Sub

'add pages to the app
Sub AddPages
	'*copy code after this line
	'code to add the Projects template code to the master HTML template
	vm.AddPage(pgProjects.name, pgProjects)
	vm.AddPage(pgComponents.name, pgComponents)
	vm.AddPage(pgComponent.name, pgComponent)
End Sub

'add content to this page
Sub AddContent
	'*copy code here to add to thos page
End Sub

'*IMPORTANT when a drawer item is clicked
Sub draweritems_click(e As BANanoEvent)
	'get the id from the event
	Dim elID As String = vm.GetIDFromEvent(e)
	Select Case elID
		'copy code below this line
		Case "pageprojects"
			'show Projects
			pgProjects.Show

	End Select
End Sub

'confirm dialog ok click
Sub confirm_ok(e As BANanoEvent)
	Dim sconfirm As String = vm.GetConfirm
	Select Case sconfirm
		'copy code below this line
		Case "delete_projects"
			'read the saved record id
			Dim RecID As String = vm.GetState("projectsprojectid", "")
			If RecID = "" Then Return
			'delete the record
			pgProjects.DeleteRecord_Projects(RecID)
		Case "delete_components"
			'read the saved record id
			Dim RecID As String = vm.GetState("componentscomponentid", "")
			If RecID = "" Then Return
			'delete the record
			pgComponents.DeleteRecord_Components(RecID)
		Case "delete_attributes"
			'read the saved record id
			Dim RecID As String = vm.GetState("attributesattrid", "")
			If RecID = "" Then Return
			'delete the record
			pgComponent.DeleteRecord_Attributes(RecID)
		Case "delete_styles"
			'read the saved record id
			Dim RecID As String = vm.GetState("stylesstyleid", "")
			If RecID = "" Then Return
			'delete the record
			pgComponent.DeleteRecord_Styles(RecID)
		Case "delete_classes"
			'read the saved record id
			Dim RecID As String = vm.GetState("classesclassid", "")
			If RecID = "" Then Return
			'delete the record
			pgComponent.DeleteRecord_Classes(RecID)
		Case "delete_events"
			'read the saved record id
			Dim RecID As String = vm.GetState("eventseventid", "")
			If RecID = "" Then Return
			'delete the record
			pgComponent.DeleteRecord_Events(RecID)
	End Select
End Sub

'confirm dialog cancel click
Sub cancel_ok(e As BANanoEvent)

End Sub

'alert dialog ok clock
Sub alert_ok(e As BANanoEvent)

End Sub

'confirm dialog cancel click
Sub confirm_cancel(e As BANanoEvent)

End Sub

'fired when the logo is clicked
Sub logo_click(e As BANanoEvent)
	'you could show the home page
	pgProjects.show
End Sub

'fired when the title is clicked
Sub title_click(e As BANanoEvent)
	'you could show the home page
	pgProjects.show
End Sub

'fire when a button in the bottom nav is clicked
Private Sub bottomnav_change(value As Object)
	
End Sub

'toggle bottom bar visibility trap
Private Sub bottomnav_updateinputvalue(value As Object)
End Sub

'click pgProjects nav button
Sub navProjects_click(e As BANanoEvent)
	'show the page Projects
	pgProjects.Show
End Sub

Sub navComponents_click(e As BANanoEvent)
	'show the page Components
	pgComponents.SHow
End Sub