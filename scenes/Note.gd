extends Control

onready var title = $'VBoxContainer/Control2/ScrollContainer/HBoxContainer/VBoxContainer/title'
onready var content = $'VBoxContainer/Control2/ScrollContainer/HBoxContainer/VBoxContainer/content'

func set_up(data):
	title.text = data.title
	content.text = data.content

func _on_BackButton_pressed():
	Global.go_back()


func _on_Note_visibility_changed():
	if visible:
		var id = Global.PATH.trim_prefix('/read/')
		var data = Global.get_data()
		if data.has(id):
			set_up(data[id])
		else:
			Global.go_back()

func _on_EditButton_pressed():
	var id = Global.PATH.trim_prefix('/read/')
	Global.set_path('/edit/' + id)
	print(Global.PATH)
