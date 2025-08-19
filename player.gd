extends CharacterBody2D

@export var move_speed: float = 100.
@onready var animatedSprite2d = $AnimatedSprite2D

func _physics_process(_delta: float):
	var input_direction = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down")
	

	velocity = input_direction * move_speed
	
	
	if velocity.x >= 0:
		animatedSprite2d.flip_h = false
	else:
		animatedSprite2d.flip_h = true
		
	
	move_and_slide()
