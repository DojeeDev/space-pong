extends RigidBody2D

signal died

var dead = false
var respawn = Vector2.ZERO
var humming = false

func lose():
	dead = true

func _on_DangerDetect_body_entered(body):
	lose()


func _integrate_forces(state):
	if dead == true:
		emit_signal("died")
		var t = state.get_transform()
		t.origin.x = respawn.x
		t.origin.y= respawn.y
		state.set_transform(t)
		set_linear_velocity(Vector2.ZERO)
		dead = false



func _on_Start_respawn_pos_updated(player, ball):
	respawn = ball


func _on_CheckPoint_respawn_pos_updated(player, ball):
	respawn = ball


func _on_BeltDetect_body_entered(body):
	$BeltHum.play()
	humming = true


func _on_BeltDetect_body_exited(body):
	humming = false
	$BeltHum.stop()
