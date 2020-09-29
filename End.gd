extends Area2D


export (String)var path 






func _on_End_body_entered(body):
	SceneChanger.change_scene(path,0.5)
