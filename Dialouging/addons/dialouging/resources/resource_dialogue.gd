@tool
@icon("res://addons/dialouging/resources/resource_dialogue_icon.png")
extends Resource
class_name Dialogue

var editor
var current = null


func _init():
	editor = load("res://addons/dialouging/scenes/dialouge_editor.tscn").instantiate()


func start():
	current = editor.get_node("GraphEdit").get_node("Start")
	proceed()


func end():
	current = null


func is_choice():
	if current.get("is_choice"):
		return true
	return false


func proceed(choice : int = 0) -> Error:
	if current == null:
		return Error.ERR_DOES_NOT_EXIST
	if choice == 0 and is_choice():
		return Error.ERR_PARAMETER_RANGE_ERROR
	if choice != 0 and not is_choice():
		return Error.ERR_PARAMETER_RANGE_ERROR
	var next
	var connections = editor.get_node("GraphEdit").get_connections()
	for connection in connections:
		if connection.from_node == current and connection.from_port == choice:
			next = connection.to_node
	current == next
	if current == editor.get_node("GraphEdit").get_node("End"):
		current = null
	return Error.OK
