extends Node

#region scene references
const SETTINGS_PANEL_SCENE := preload("res://scene/settings_panel.tscn")
#endregion

#region node references
var settings_panel : SettingsPanel
var test_field_panel : TestFieldPanel
var ui_container : UiContainer
var wpm_panel : WpmPanel
var restart_test_button : Button
var main : Control
var main_panel : Panel
#endregion
