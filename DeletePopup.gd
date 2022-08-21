extends ColorRect

var id = ''
var data = {}

func set_up():
	id = Global.PATH.trim_prefix('/delete/')
	data = Global.get_data()
	
	$PanelContainer/VBoxContainer/Control/Label.text = data[id].title

func _on_DeletePopup_visibility_changed():
	if visible:
		set_up()


func _on_DeleteButton_pressed():
	if data.has(id):
		data.erase(id)
		
	
	var file = File.new()
	file.open(Global.DATA_FILE_PATH, File.WRITE)
	var data_str = to_json(data)
	file.store_string(data_str)
	file.close()
	Global.go_back()
	Global.NOTIFICATION.show_not("Замітку видалено")

func _on_CancelButton_pressed():
	Global.go_back()
