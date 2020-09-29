extends Node2D

var tile_size = 16
var normie_grav = Vector2(0,1)
var gravity = Vector2(0,1)
var gravity_strength = 600
var mouse_mass = 100

var song = ""


func _input(event):
	if event.is_action_pressed("restart_button"):
		get_tree().reload_current_scene()


func play_song(name):
	stop_music()
	song = name
	if song == "main":
		$MainTheme.play()
	elif song == "title":
		$TitleTheme.play()
	elif song == "credits":
		$CreditsTheme.play()


func stop_music():
	song = ""
	$MainTheme.stop()
	$TitleTheme.stop()
	$CreditsTheme.stop()


func _on_MainTheme_finished():
	if song == "main":
		$MainTheme.play()


func _on_TitleTheme_finished():
	if song == "title":
		$TitleTheme.play()


func _on_CreditsTheme_finished():
	if song == "credits":
		$CreditsTheme.play()
