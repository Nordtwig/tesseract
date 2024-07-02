extends Node3D

@export var holo_voxel_scene: Resource

var voxel_overlay = []
var overlay_width = 10
var overlay_height = 10
var overlay_depth = 10


func _ready() -> void:
	for x in overlay_width:
		voxel_overlay.append([])
		for y in overlay_height:
			voxel_overlay[x].append([])
			for z in overlay_depth:
				print(str(x) + "," + str(y) + "," + str(z))
				var holo_voxel_instance = holo_voxel_scene.instantiate()
				add_child(holo_voxel_instance)
				holo_voxel_instance.position = Vector3(x * Game.VOXEL_SIZE, y  * Game.VOXEL_SIZE, z  * Game.VOXEL_SIZE)
				voxel_overlay[x][y].append(0)

