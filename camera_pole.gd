extends Node3D

func _process(delta) -> void:
	if Input.is_action_pressed("rotate_camera"):
		rotation.x += MouseInput.relative.y * delta
		rotation.y += MouseInput.relative.x * delta
	if Input.is_action_pressed("move_up"):
		position.z -= 1.0 * delta
	if Input.is_action_pressed("move_down"):
		position.z += 1.0 * delta
	if Input.is_action_pressed("move_left"):
		position.x -= 1.0 * delta
	if Input.is_action_pressed("move_right"):
		position.x += 1.0 * delta

