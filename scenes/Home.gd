extends Control

onready var card = preload("res://scenes/Card.tscn")
onready var hbox = $'VBoxContainer/PanelContainer/ScrollContainer/VBoxContainer/HBoxContainer'
onready var SearchBar = $'VBoxContainer/Header/HBoxContainer/SearchBar'

export var min_card_size = 250
	

func set_up(vboxes: Array):
	var datas = Global.get_data()
	
	var num_of_vbox = vboxes.size()
	var count = 0
	for data in datas.values():
		if SearchBar.text != "":
			if not SearchBar.text in data.title:
				continue
		var card_item = card.instance()
		card_item.set_up(data)
		
		vboxes[count].add_child(card_item)
		count += 1
		if count >= num_of_vbox:
			count = 0
			


func create_vboxes():
	var x = rect_size.x
	var number_of_vbox = floor(x/min_card_size)

	
	for c in hbox.get_children():
		c.queue_free()
	var vboxes = []
	for n in number_of_vbox:
		var vbox = VBoxContainer.new()
		hbox.add_child(vbox)
		vbox.add_constant_override('separation', 20)
		vboxes.append(vbox)
	return vboxes

func _on_Home_resized():
	if visible:
		var vboxes = create_vboxes()
		set_up(vboxes)

func _on_NewButton_pressed():
	Global.set_path('/new')
	$"../NewNote".reset()

func _on_Home_visibility_changed():
	if visible:
		var vboxes = create_vboxes()
		set_up(vboxes)


func _on_SearchBar_text_changed(new_text):
	var vboxes = create_vboxes()
	set_up(vboxes)
