@tool
extends Control

var speech_dialouge
var choice_dialouge

var mouse_hovering = false
var add_button
var add_button_popup

func _ready():
	speech_dialouge = load("res://addons/dialouging/scenes/speech_dialouge.tscn")
	choice_dialouge = load("res://addons/dialouging/scenes/choice_dialouge.tscn")
	add_button = get_node("Add").duplicate()
	add_button.visible = true
	$GraphEdit.get_menu_hbox().add_child(add_button)
	add_button_popup = add_button.get_popup()
	add_button_popup.id_pressed.connect(_on_add_popup_id_pressed)
	$GraphEdit.connect_node("Start", 0, "End", 0)


func _on_mouse_entered():
	mouse_hovering = true


func _on_mouse_exited():
	mouse_hovering = false


func _on_add_popup_id_pressed(id : int):
	if id == 0:
		add_speech_dialouge()
	elif id == 1:
		add_choice_dialouge()


func add_speech_dialouge():
	var new = speech_dialouge.instantiate()
	new.position_offset = $GraphEdit.scroll_offset + Vector2(50, 50)
	$GraphEdit.add_child(new)


func add_choice_dialouge():
	var new = choice_dialouge.instantiate()
	new.position_offset = $GraphEdit.scroll_offset + Vector2(50, 50)
	$GraphEdit.add_child(new)


func _on_graph_edit_connection_request(from_node, from_port, to_node, to_port):
	for connection in $GraphEdit.get_connection_list():
		if connection.from_node == from_node and connection.from_port == from_port:
			$GraphEdit.disconnect_node(connection.from_node, connection.from_port, connection.to_node, connection.to_port)
	$GraphEdit.connect_node(from_node, from_port, to_node, to_port)


func _on_graph_edit_disconnection_request(from_node, from_port, to_node, to_port):
	$GraphEdit.disconnect_node(from_node, from_port, to_node, to_port)
