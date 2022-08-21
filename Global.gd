extends Node

const COLORS = {
	'bg': '#262626',
	'card_bg': "#3c3c3c",
	'accent': '#d7bde2',
	'text': '#E2E2E2',
	'text_dim': '#878787',
	'text_higlight': '#FBFBFB',
	'CARDS': ['#e6b0aa', '#f9e79f', '#d7bde2', '#d2b4de', '#a9cce3', '#aed6f1',
	'#a2d9ce', '#f9e79f', '#fad7a0', '#f5cba7', '#f7f9f9', '#abebc6']
}

var PATH = '/'
var HYSTORY = ['/']
var DATA_FILE_PATH = ProjectSettings.globalize_path('user://gnode_data.json')
onready var NOTIFICATION = get_node("/root/Control/NotificationArea")

func go_back() -> void:
	if HYSTORY.size() > 1:
		PATH = HYSTORY[-1]
		HYSTORY.pop_back()
	else:
		set_path('/')
		HYSTORY = ['/']
func get_data():
	var file = File.new()
	file.open(DATA_FILE_PATH, File.READ)
	if file.file_exists(DATA_FILE_PATH):
		var data = JSON.parse(file.get_as_text()).result
		file.close()
		return data
	else:
		file.close()
		return {}

func set_path(path) -> void:
	HYSTORY.append(PATH)
	PATH = path

func is_clicked(event) -> bool:
	return InputEventMouseButton and event.is_pressed() and event.get_button_index() == 1
