@tool
extends GraphNode

var character_name
var speech


func _ready():
	character_name = ""
	speech = ""
	var close_button = Button.new()
	close_button.text = "x"
	close_button.pressed.connect(_on_delete_request)
	get_titlebar_hbox().add_child(close_button)


func _on_character_name_edit_text_changed(new_text):
	character_name = new_text


func _on_speech_edit_text_changed(new_text):
	speech = new_text


func _on_delete_request():
	var connections = get_parent().get_connection_list()
	for connection in connections:
		if connection.from_node == name or connection.to_node == name:
			get_parent().disconnect_node(connection.from_node, connection.from_port, connection.to_node, connection.to_port)
	get_parent().remove_child(self)
	queue_free()
