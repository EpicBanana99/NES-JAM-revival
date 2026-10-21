extends Node2D
class_name Floor

@export var min_rooms = 7
@export var max_rooms = 14


var floor_map

func place_room(room : PackedScene, pos_y : int, pos_x :int, color : Global.colors):
	var new_room : Room = room.instantiate()
	new_room.room_color = color
	add_child(new_room)
	new_room.position = Vector2(256 * pos_y, 240 * pos_x)

func generate_floor(room_n):
	for i in range(0, room_n):
		pass

func _ready() -> void:
	generate_floor(randi_range(min_rooms, max_rooms))
