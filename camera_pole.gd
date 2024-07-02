extends CharacterBody3D

var new_position: Vector3 = Vector3.ZERO
var move_speed: float = 1.0
var speed_modifier: float = 2.0
var should_move_to_new_position: bool = false
var forward = Vector3.FORWARD

@onready var pivot: Node3D = $Pivot


func _ready() -> void:
	Events.voxel_right_clicked.connect(on_voxel_right_clicked)


func _process(delta) -> void:
	if Input.is_action_pressed("rotate_camera"):
		pivot.rotation.x +=  MouseInput.relative.y * delta
		pivot.rotation.x = clampf(pivot.rotation.x, -1.6, 1.6)
		pivot.rotation.y += MouseInput.relative.x * delta


func _physics_process(delta) -> void:
	forward = -pivot.transform.basis.z
	get_input()
	if should_move_to_new_position:
		if position.distance_to(new_position) <= 0.09:
			should_move_to_new_position = false
		else:
			position = position.lerp(new_position, delta * (move_speed * speed_modifier))
	move_and_slide()
		

func get_input() -> void:
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_up"):
		direction += forward
	elif Input.is_action_pressed("move_down"):
		direction += -forward
	if Input.is_action_pressed("move_left"):
		direction += -forward.cross(Vector3.UP)
	elif Input.is_action_pressed("move_right"):
		direction += forward.cross(Vector3.UP)
	if direction != Vector3.ZERO:
		should_move_to_new_position = false
		direction.y = position.y
	print(direction)
	velocity = direction * move_speed
	print(velocity)


func on_voxel_right_clicked(voxel_position: Vector3) -> void:
	if voxel_position != position:
		new_position = voxel_position
		should_move_to_new_position = true
