extends Node2D
class_name Floor

@export var min_rooms = 7
@export var max_rooms = 14

var floor_map

func generate_floor(room_n):
	pass

func _ready() -> void:
	generate_floor(randi_range(min_rooms, max_rooms))
