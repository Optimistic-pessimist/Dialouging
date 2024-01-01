@tool
extends GraphNode

# Identifier
var is_choice = true

var character_name
var choice_count
var choices


func generate_choices():
	var i = 1
	while i <= choice_count:
		var new_line_edit = LineEdit.new()
		new_line_edit.expand_to_text_length = true
		new_line_edit.text_changed.connect(_on_choices_line_edit_value_changed.bind(i))
		add_child(new_line_edit)
		set_slot(i, false, 0, Color.WHITE, true, 0, Color.WHITE)
		i += 1
	choices = [null]
	i = 1
	while i <= choice_count:
		choices.append("")
		i += 1


func _ready():
	character_name = ""
	var new_line_edit = LineEdit.new()
	var close_button = Button.new()
	close_button.text = "x"
	close_button.pressed.connect(_on_delete_request)
	get_titlebar_hbox().add_child(close_button)


func _on_choices_line_edit_value_changed(value, id):
	choices[id] = value


func _on_delete_request():
	var connections = get_parent().get_connection_list()
	for connection in connections:
		if connection.from_node == name or connection.to_node == name:
			get_parent().disconnect_node(connection.from_node, connection.from_port, connection.to_node, connection.to_port)
	get_parent().remove_child(self)
	queue_free()


func _on_choice_count_edit_text_changed(new_text):
	var flag = true
	for i in new_text:
		if i not in "1234567890":
			flag = false
			break
	if flag:
		$VBoxContainer/ChoiceCount/Edit.editable = false
		choice_count = int(new_text)
		generate_choices()


func _on_charater_name_edit_text_changed(new_text):
	character_name = new_text
