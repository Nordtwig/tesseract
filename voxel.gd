extends RigidBody3D


@onready var voxel_scene: PackedScene = preload("res://voxel.tscn")


func _ready() -> void:
	input_event.connect(on_voxel_input_event)


func on_voxel_input_event(camera: Node, event: InputEvent, click_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		var voxel_instance = voxel_scene.instantiate()
		voxel_instance.set_script(get_script())
		get_tree().get_root().get_node("Main").add_child(voxel_instance)
		voxel_instance.position = position + (normal * Game.VOXEL_SIZE)
