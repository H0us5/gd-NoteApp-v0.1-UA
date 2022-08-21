extends Control

onready var label = $'VBoxContainer/Control2/ScrollContainer/HBoxContainer/VBoxContainer/Label'
onready var title = $'VBoxContainer/Control2/ScrollContainer/HBoxContainer/VBoxContainer/title'
onready var content = $'VBoxContainer/Control2/ScrollContainer/HBoxContainer/VBoxContainer/content'
onready var saveBtn = $'VBoxContainer/Control/Control/SaveButton'

var bg = ''
var id = ''
var months = ['Січ', "Лют", "Бер", "Кві", "Тра", "Чер", "Лип", "Сер", "Вер", "Жов", "Лис", "Гру"]

func _process(_delta):
	if len(title.text.strip_edges()) == 0 and not saveBtn.set_disabled(true):
		saveBtn.set_disabled(true)
		saveBtn.mouse_default_cursor_shape = Control.CURSOR_FORBIDDEN
	elif len(title.text.strip_edges()) != 0:
		saveBtn.set_disabled(false)
		saveBtn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
func reset():
	title.text = ''
	content.text = 'Напишіть що небудь...'
	label.set_text('')
	label.visible = false
	title.visible = true
	bg = Global.COLORS.CARDS[randi()%len(Global.COLORS.CARDS)]
	title.grab_focus()
	gen_id()
	$Popup.visible = false
	
func gen_id():
	var chars = '0123456789'
	var id_length = 12
	id = ''
	for i in id_length:
		id += chars[randi()%chars.length()]

func _on_BackButton_pressed():
	if title.text.strip_edges() != '' or content.text != 'Напишіть що небудь...':
		$Popup.visible = true
	else:
		Global.go_back()

func _on_SaveButton_pressed():
	bg = Global.COLORS.CARDS[randi()%len(Global.COLORS.CARDS)]
	
	var file = File.new()
	file.open(Global.DATA_FILE_PATH, File.READ_WRITE)
	var data = {}
	if file.file_exists(Global.DATA_FILE_PATH):
		data = JSON.parse(file.get_as_text()).result
	else:
		file.open(Global.DATA_FILE_PATH, File.WRITE)
	var dates = OS.get_date()
	id = title.text + id
	var note = {
		'title': title.text,
		'content': content.text,
		'bg': bg,
		'id': id,
		'date': '{date} {month}, {year}'.format({
			'month':months[dates['month']-1],
			'date':dates['day'],
			'year':dates['year']
			})
	}
	data[id] = note
	file.store_line(to_json(data))
	file.close()
	print('Saved')
	Global.go_back()
	Global.set_path('/read/' + id)
	Global.NOTIFICATION.show_not("Створено замітку " + title.text)
	


func _on_StayButton_pressed():
	$Popup.visible = false


func _on_LeaveButton_pressed():
	Global.go_back()


func _on_content_focus_entered():
	if content.text == 'Напишіть що небудь...':
		content.text = ''


func _on_content_focus_exited():
	if content.text.strip_edges() == '':
		content.text = 'Напишіть що небудь...'


func _on_title_focus_exited():
	label.set_text(title.text)
	if title.text != '':
		label.visible = true
		title.visible = false
	
	


func _on_Label_gui_input(event):
	if Global.is_clicked(event):
		title.visible = true
		label.visible = false
		title.grab_focus()
