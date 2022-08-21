extends Control


func show_not(message):
	$Panel/HBoxContainer/Label.text = message
	$AnimationPlayer.play("show")
	$Timer.start()

func _on_CloseNoti_pressed():
	$AnimationPlayer.play_backwards("show")


func _on_Timer_timeout():
	$AnimationPlayer.play_backwards("show")
