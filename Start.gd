extends Area2D


signal respawn_pos_updated(player,ball)

onready var ball_pos = $BallPos

func _on_Start_body_entered(body):
	emit_signal("respawn_pos_updated",global_position,ball_pos.global_position)
