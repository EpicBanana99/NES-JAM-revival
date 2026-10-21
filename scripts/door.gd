extends StaticBody2D
class_name Door

enum types {CLOSED, CRACKED, KEY, BOSS, OPEN, BOMBED}

var dir = Global.directions.LEFT
var col = Global.colors.GREEN
var typ = types.CLOSED
var is_boss = false

func render_door(direction: Global.directions, color: Global.colors, type : types):
	var dir_string = "horizontal"
	var color_string = "green"
	var type_string = "closed"
	
	typ = type
	dir = direction
	col = color

	if direction == Global.directions.LEFT :
		$Sprite.flip_h = false
	elif direction == Global.directions.RIGHT:
		$Sprite.flip_h = true
	elif direction == Global.directions.UP:
		$Sprite.flip_v = false
	elif direction == Global.directions.DOWN:
		$Sprite.flip_v = true
	
	if direction == Global.directions.UP or direction == Global.directions.DOWN:
		dir_string = "vertical"
		$CollisionBox.position = Vector2(16,16)
		$CollisionBox.rotation_degrees = 0
	
	if color == Global.colors.RED:
		color_string = "red"
	elif color == Global.colors.YELLOW:
		color_string = "yellow"
	
	if type == types.CRACKED :
		type_string = "cracked"
	elif type == types.BOSS :
		type_string = "boss"
		is_boss = true
	elif type == types.KEY :
		type_string = "key"
	elif type == types.OPEN :
		type_string = "open"
	elif type == types.BOMBED :
		type_string = "bombed"

	$CollisionBox.disabled = false
	if get_children().size() > 2:
		get_child(2).queue_free()
	if type == types.BOMBED or type == types.OPEN:
		$CollisionBox.disabled = true
		var sub_sprite = Sprite2D.new()
		sub_sprite.texture = load("res://assets/door_sprites/door_subsprites/" + type_string + "_" + color_string + "_" + dir_string + "_subsprite.tres")
		sub_sprite.flip_h = $Sprite.flip_h
		sub_sprite.flip_v = $Sprite.flip_v
		sub_sprite.z_index = 1
		sub_sprite.centered = false
		if $Sprite.flip_h:
			sub_sprite.offset.x = 15
		if $Sprite.flip_v:
			sub_sprite.offset.y = 15
		add_child(sub_sprite)
	
	$Sprite.texture = load("res://assets/door_sprites/door_main_sprites/" + type_string + "_" + color_string + "_" + dir_string + ".tres")
	
	
func open_door():
	if typ == types.CRACKED or typ == types.BOMBED:
		render_door(dir, col, types.BOMBED)
	else:
		render_door(dir, col, types.OPEN)
func close_door():
	if typ == types.BOMBED or typ == types.CRACKED:
		render_door(dir, col, types.CRACKED)
	elif is_boss:
		render_door(dir, col, types.BOSS)
	else:
		render_door(dir, col, types.CLOSED)
	
