extends Camera2D

var parent = get_parent()

func _physics_process(delta):
	if parent:
		global_rotation = 0
