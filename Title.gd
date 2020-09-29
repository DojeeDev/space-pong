extends Node2D

func _ready():
	Globals.play_song("title")

func _input(event):
	if event.is_action_pressed("Start"):
		SceneChanger.change_scene("res://Story_start.tscn",0.5)
