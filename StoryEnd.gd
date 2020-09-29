extends Node2D


func _ready():
	Globals.play_song("credits")


func _input(event):
	if event.is_action_pressed("Start"):
		SceneChanger.change_scene("res://Credits.tscn",0.5)
