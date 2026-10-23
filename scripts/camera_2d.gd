extends Camera2D

var is_zoomed = true
var t = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = Vector2(floor($"../Player".position.x/256)*256,floor($"../Player".position.y/240)*240)
	if Input.is_action_just_pressed("zoom"):
		if is_zoomed:
			zoom = Vector2(0.1,0.1)
			anchor_mode = Camera2D.ANCHOR_MODE_DRAG_CENTER
			is_zoomed=false
		else:
			zoom = Vector2(1,1)
			anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
			is_zoomed = true
