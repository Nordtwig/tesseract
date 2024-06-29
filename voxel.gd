extends StaticBody3D

var is_mouse_entered: bool = false

@onready var voxel_scene: PackedScene = preload("res://voxel.tscn")


func _ready() -> void:
	mouse_entered.connect(on_voxel_mouse_entered)
	mouse_exited.connect(on_voxel_mouse_exited)


func _input(event):
	if event.is_action_pressed("left_click") and is_mouse_entered:
		var voxel_instance = voxel_scene.instantiate()
		get_tree().get_root().add_child(voxel_instance)
		voxel_instance.position.x += Game.VOXEL_SIZE
		print(voxel_instance.position.x)


func on_voxel_mouse_entered() -> void:
	is_mouse_entered = true


func on_voxel_mouse_exited() -> void:
	is_mouse_entered = false
	
