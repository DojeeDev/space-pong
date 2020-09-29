extends Node2D

func _input(event):
	if event.is_action_pressed("Start"):
		SceneChanger.change_scene("res://Title.tscn",0.5)
