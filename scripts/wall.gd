extends StaticBody2D
class_name Wall

func render_wall(direction: Global.directions, color: Global.colors):
	var dir_string = "horizontal"
	var color_string = "green"
	
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
	
	$Sprite.texture = load("res://assets/wall_sprites/" + color_string + "_" + dir_string + ".tres")
