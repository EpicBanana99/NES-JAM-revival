extends CharacterBody2D

# references to children
var sprite : AnimatedSprite2D
var collision_box : CollisionShape2D


# movement variables
var dir : Vector2
const movements = {
	"right" : Vector2.RIGHT,
	"left" : Vector2.LEFT,
	"up" : Vector2.UP,
	"down" : Vector2.DOWN
}

var input_history : Array[String]
var latest_input : String
@export var speed : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# assigning references to children
	sprite = $AnimatedSprite2D
	collision_box = $CollisionShape2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# resetting the movement vector when not pressing anything
	dir = Vector2.ZERO
	get_inputs()

	# flipping the sprites for left/right directions
	if latest_input == "left":
		sprite.flip_h = true
	elif latest_input == "right":
		sprite.flip_h = false
	
	animate()

# setting the vector the last-pressed direction, this way it is more accurate to zelda NES
func get_inputs():
	for input in movements.keys():
		if Input.is_action_just_pressed(input):
			input_history.erase(input)
			input_history.append(input)
		if Input.is_action_just_released(input):
			input_history.erase(input)
	if input_history.size():
		dir = movements[input_history[input_history.size()-1]]
		latest_input = input_history[input_history.size()-1]

func animate():
	if (latest_input == "left" or latest_input == "right") and velocity == Vector2.ZERO:
		sprite.play("idleDir")
	elif (latest_input == "left" or latest_input == "right") and velocity != Vector2.ZERO:
		sprite.play("walkDir")
	elif latest_input == "up" and velocity == Vector2.ZERO:
		sprite.play("idleUp")
	elif latest_input == "up" and velocity != Vector2.ZERO:
		sprite.play("walkUp")
	elif latest_input == "down" and velocity == Vector2.ZERO:
		sprite.play("idleDown")
	elif latest_input == "down" and velocity != Vector2.ZERO:
		sprite.play("walkDown")

func _physics_process(delta: float) -> void:
	# applying basic movement
	velocity = dir * delta * speed * 100
	move_and_slide()
