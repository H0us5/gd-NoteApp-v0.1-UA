extends Control

onready var Home = $Home
onready var NewNote = $NewNote
onready var Note = $Note
onready var EditNote = $EditNote
onready var DeletePopup = $DeletePopup

func _process(_delta):
	if Global.PATH == '/' and not Home.visible:
		Home.visible = true
		NewNote.visible = false
		Note.visible = false
		EditNote.visible = false
		DeletePopup.visible = false
	if Global.PATH == '/' and Home.visible and DeletePopup.visible:
		Home.visible = false
		Home.visible = true
		DeletePopup.visible = false
	elif Global.PATH == '/new' and not NewNote.visible:
		Home.visible = false
		NewNote.visible = true
		Note.visible = false
		EditNote.visible = false
		DeletePopup.visible = false
	elif Global.PATH.begins_with('/read/') and not Note.visible:
		Home.visible = false
		NewNote.visible = false
		Note.visible = true
		EditNote.visible = false
		DeletePopup.visible = false
	elif Global.PATH.begins_with('/edit/') and not EditNote.visible:
		Home.visible = false
		NewNote.visible = false
		Note.visible = false
		EditNote.visible = true
		DeletePopup.visible = false
	elif Global.PATH.begins_with('/delete/') and not DeletePopup.visible:
		DeletePopup.visible = true


