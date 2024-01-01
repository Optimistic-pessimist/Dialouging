@tool
extends EditorPlugin

var bottom_panel_editor


func _enter_tree():
	pass


func _exit_tree():
	pass


func _handles(object):
	if object is Dialouge:
		bottom_panel_editor = object.editor
		return true
	return false


func _make_visible(visible):
	if visible:
		add_control_to_bottom_panel(bottom_panel_editor, "Dialouge Editor")
	else:
		remove_control_from_bottom_panel(bottom_panel_editor)


func _edit(object):
	if object == null:
		_make_visible(false)
