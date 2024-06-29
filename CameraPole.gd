extends Node3D


func _process(delta) -> void:
	if Input.is_action_pressed("move_up"):
		rotation.x -= 1.0 * delta
	if Input.is_action_pressed("move_down"):
		rotation.x += 1.0 * delta
	if Input.is_action_pressed("move_left"):
		rotation.y -= 1.0 * delta
	if Input.is_action_pressed("move_right"):
		rotation.y += 1.0 * delta


