extends PanelContainer

var bg = '#f5b7b1'
var id = ''

func _ready():
	pass 


func set_up(data):
	get_stylebox('panel', '').bg_color = Global.COLORS.CARDS[randi()%len(Global.COLORS.CARDS)]
	$VBoxContainer/title.text = data.title
	$VBoxContainer/date.text = data.date
	id = data.id


func _on_Card_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.get_button_index() == 1:
			Global.set_path('/read/'+id)
		elif event.get_button_index() == 2:
			Global.set_path('/delete/'+id)
