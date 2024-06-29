extends StaticBody3D

var main

var is_mouse_entered: bool = false

@onready var voxel_scene: PackedScene = preload("res://voxel.tscn")


func _ready() -> void:
	mouse_entered.connect(on_voxel_mouse_entered)
	mouse_exited.connect(on_voxel_mouse_exited)
	main = get_tree().get_root().get_node("Main")


func _input(event):
	if event.is_action_pressed("left_click") and is_mouse_entered:
		var from = main.camera.project_ray_origin(event.position)
		var to = from + main.camera.project_ray_normal(event.position) * 100
		var cursor_position = Plane(Vector3.UP, transform.origin.y).intersects_ray(from, to)
		var voxel_instance = voxel_scene.instantiate()
		get_tree().get_root().add_child(voxel_instance)
		voxel_instance.position = cursor_position


func on_voxel_mouse_entered() -> void:
	print(name)
	is_mouse_entered = true


func on_voxel_mouse_exited() -> void:
	is_mouse_entered = false
	
