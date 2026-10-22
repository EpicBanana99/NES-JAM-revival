extends Node2D
class_name Floor

@export var min_rooms = 7
@export var max_rooms = 14

const dirs = [[-1,0], [1,0], [0,1], [0,-1]]
const dir_enum_vals = [Global.directions.LEFT, Global.directions.RIGHT, Global.directions.DOWN, Global.directions.UP]

var normal_room = preload("res://scenes/rooms/room.tscn")
var boss_room = preload("res://scenes/rooms/boss_room.tscn")

var floor_map : Array[Room]= []

func place_room(pos_x : int, pos_y :int, type : String):
	var new_room : Room
	if type == "boss":
		new_room = boss_room.instantiate()
		new_room.room_color = Global.colors.RED
	else:
		new_room = normal_room.instantiate()
	add_child(new_room)
	new_room.position = Vector2(256 * pos_x, 240 * pos_y)
	new_room.cords = [pos_x, pos_y]
	return new_room

func place_doors():
	var room_cords = []
	var room_types = []
	for room in floor_map:
		print()
		room_cords.append(room.cords)
		if room is BossRoom:
			room_types.append(Door.types.BOSS)
		else:
			room_types.append(Door.types.CLOSED)
	print(room_types)
	for room in floor_map:
		var current_point = room.cords
		var i = 0
		for dir in dirs:
			var checked_cords = [current_point[0]+dir[0], current_point[1]+dir[1]]
			if checked_cords in room_cords:
				var ch_t = room_types[room_cords.find(checked_cords)]
				var cr_t = room_types[room_cords.find(current_point)]
				var t = ch_t if cr_t == Door.types.CLOSED else cr_t
				room.set_door(dir_enum_vals[i], room.room_color, t)
			else:
				room.set_wall(dir_enum_vals[i], room.room_color)
			i+=1
	

func generate_floor(room_n):
	var available = [[0,0]]
	var taken = []
	for i in range(0, room_n):
		var current_point = available.pop_at(randi_range(0, available.size()-1))
		if i != room_n-1:
			floor_map.append(place_room(current_point[0], current_point[1], "normal"))
		else:
			floor_map.append(place_room(current_point[0], current_point[1], "boss"))
		taken.append(current_point)
		for dir in dirs:
			var checked_point = [current_point[0]+dir[0], current_point[1]+dir[1]]
			if checked_point in taken or checked_point in available:
				continue
			available.append(checked_point)
	place_doors()

func _ready() -> void:
	generate_floor(randi_range(min_rooms, max_rooms))
