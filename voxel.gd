extends RigidBody3D


@export var voxel_scene: Resource
@export var mesh_sides: Array[MeshInstance3D]

var placeholder_voxel_instance: Node = null
var mouse_is_over_voxel: bool = false
var last_normal: Vector3


func _ready() -> void:
	input_event.connect(on_voxel_input_event)
	mouse_entered.connect(on_voxel_mouse_entered)
	mouse_exited.connect(on_voxel_mouse_exited)
	voxel_scene = load("res://voxel.tscn")


func set_material(material: String) -> void:
	for mesh in mesh_sides:
		mesh.material_override = load(material)


func on_voxel_input_event(camera: Node, event: InputEvent, click_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		placeholder_voxel_instance.set_material("res://metal_voxel.tres")
		placeholder_voxel_instance.get_node("CollisionShape3D").disabled = false
		placeholder_voxel_instance = null
	if event.is_action_released("right_click"):
		Events.voxel_right_clicked.emit(position)
	if event is InputEventMouseMotion:
		if !placeholder_voxel_instance and mouse_is_over_voxel:
			placeholder_voxel_instance = voxel_scene.instantiate()
			placeholder_voxel_instance.set_script(get_script())
			get_tree().get_root().get_node("Main").add_child(placeholder_voxel_instance)
			placeholder_voxel_instance.set_material("res://holo_voxel.tres")
			placeholder_voxel_instance.get_node("CollisionShape3D").disabled = true
			placeholder_voxel_instance.position = position + (normal * Game.VOXEL_SIZE)
			last_normal = normal
		elif placeholder_voxel_instance and last_normal != normal:
			placeholder_voxel_instance.position = position + (normal * Game.VOXEL_SIZE)


func on_voxel_mouse_entered() -> void:
	mouse_is_over_voxel = true


func on_voxel_mouse_exited() -> void:
	if placeholder_voxel_instance != null:
		placeholder_voxel_instance.queue_free()
	mouse_is_over_voxel = false
