extends Control

onready var title = $VBoxContainer/Control2/ScrollContainer/HBoxContainer/VBoxContainer/title
onready var content = $VBoxContainer/Control2/ScrollContainer/HBoxContainer/VBoxContainer/content
onready var label = $VBoxContainer/Control2/ScrollContainer/HBoxContainer/VBoxContainer/Label

var old_data = {}

func set_up(data):
	old_data = data
	title.text = data.title
	label.text = data.title
	content.text = data.content
	title.grab_focus()
	title.set_cursor_position(title.text.length())

func _on_EditNote_visibility_changed():
	if visible:
		var id = Global.PATH.trim_prefix('/edit/')
		var data = Global.get_data()
		if id in data:
			set_up(data[id])
			print(id)
			$Popup.visible = false
	else:
		Global.set_path('/')

func _on_BackButton_pressed():
	if old_data.title != title.text or old_data.content != content.text:
		$Popup.visible = true
	else:
		Global.go_back()

func _on_StayButton_pressed():
	$Popup.visible = false

func _on_LeaveButton_pressed():
	Global.go_back()


func _on_SaveButton_pressed():
	var id = Global.PATH.trim_prefix('/edit/')
	var data = Global.get_data()
	
	data[id].title = title.text
	data[id].content = content.text
	
	var file = File.new()
	file.open(Global.DATA_FILE_PATH, File.WRITE)
	var data_str = to_json(data)
	file.store_string(data_str)
	file.close()
	Global.go_back()
	Global.NOTIFICATION.show_not("Збережено")
