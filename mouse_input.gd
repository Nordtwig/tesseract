extends Node

var relative: Vector2
var scroll_forward: int
var scroll_backward: int

var last_frame: float
var last_mouse_move: float
var last_scroll_forward: float
var last_scroll_backward: float


func _process(delta) -> void:
	if last_mouse_move < last_frame:
		relative = Vector2.ZERO
	
	if last_scroll_forward < last_frame:
		scroll_forward = 0
	
	if last_scroll_forward < last_frame:
		scroll_backward = 0

	last_frame += delta


func _input(event):
	if event is InputEventMouseMotion:
		last_mouse_move = last_frame
		relative = event.relative
	elif event is InputEventMouseButton:
		if event.is_action_pressed("scroll_forward"):
			last_scroll_forward = last_frame
			scroll_forward = 1
		if event.is_action_pressed("scroll_backward"):
			last_scroll_backward = last_frame
			scroll_backward = 1