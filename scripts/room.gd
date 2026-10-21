extends StaticBody2D
class_name Room

var wall = preload("res://scenes/wall.tscn")
var door = preload("res://scenes/door.tscn")

var room_color = Global.colors.GREEN
var wall_markers = []

func set_wall(direction: Global.directions, color: Global.colors):
	var new_wall = wall.instantiate()
	new_wall.render_wall(direction, color)
	if direction == Global.directions.RIGHT:
		$RightWallMarker.add_child(new_wall)
	elif direction == Global.directions.LEFT:
		$LeftWallMarker.add_child(new_wall)
	elif direction == Global.directions.UP:
		$UpWallMarker.add_child(new_wall)
	elif direction == Global.directions.DOWN:
		$DownWallMarker.add_child(new_wall)

func set_door(direction: Global.directions, color: Global.colors, type : Door.types):
	var new_door = door.instantiate()
	new_door.render_door(direction, color, type)
	if direction == Global.directions.RIGHT:
		$RightWallMarker.add_child(new_door)
	elif direction == Global.directions.LEFT:
		$LeftWallMarker.add_child(new_door)
	elif direction == Global.directions.UP:
		$UpWallMarker.add_child(new_door)
	elif direction == Global.directions.DOWN:
		$DownWallMarker.add_child(new_door)

func open_doors():
	for m in wall_markers:
		wall = m.get_child(0)
		if wall is Door:
				wall.open_door()

func close_doors():
	for m in wall_markers:
		wall = m.get_child(0)
		if wall is Door:
				wall.close_door()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wall_markers = [$LeftWallMarker, $RightWallMarker, $UpWallMarker, $DownWallMarker]
	var room_string = "green"
	if room_color == Global.colors.RED:
		room_string = "red"
	elif room_color == Global.colors.YELLOW:
		room_string = "yellow"
	
	$RoomSprite.texture = load("res://assets/room_sprites/room_"+ room_string +".tres")
	
	set_walls()

func set_walls():
	set_wall(Global.directions.LEFT, room_color)
	set_door(Global.directions.RIGHT, room_color, Door.types.BOSS)
	set_door(Global.directions.UP, room_color, Door.types.CRACKED)
	set_door(Global.directions.DOWN, room_color, Door.types.KEY)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open"):
		open_doors()
	if Input.is_action_just_pressed("close"):
		close_doors()
