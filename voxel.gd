extends RigidBody3D

var voxel_scene: PackedScene
var holo_voxel_scene: PackedScene
var holo_voxel_instance: Node = null

# @onready var voxel_scene: PackedScene = preload("res://voxel.tscn")
# @onready var holo_voxel_scene: PackedScene = preload("res://HoloVoxel.tscn")


func _ready() -> void:
	input_event.connect(on_voxel_input_event)
	voxel_scene = preload("res://voxel.tscn")
	holo_voxel_scene = preload("res://holo_voxel.tscn")


func on_voxel_input_event(camera: Node, event: InputEvent, click_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		var voxel_instance = voxel_scene.instantiate()
		voxel_instance.set_script(get_script())
		get_tree().get_root().get_node("Main").add_child(voxel_instance)
		voxel_instance.position = position + (normal * Game.VOXEL_SIZE)
	elif event is InputEventMouseMotion:
		if !holo_voxel_instance:
			holo_voxel_instance = holo_voxel_scene.instantiate()
			holo_voxel_instance.set_script(get_script())
			get_tree().get_root().get_node("Main").add_child(holo_voxel_instance)
			holo_voxel_instance.position = position + (normal * Game.VOXEL_SIZE)
