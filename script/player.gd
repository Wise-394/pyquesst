extends CharacterBody2D
class_name Player

# =====================================================
# --- Exported Variables ---
# =====================================================
@export var move_speed: float = 100.0

# =====================================================
# --- Node References ---
# =====================================================
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

# =====================================================
# --- State Management ---
# =====================================================
enum PlayerState { IDLE, MOVE, DIALOGUE }
var current_state: PlayerState = PlayerState.IDLE

# =====================================================
# --- Lifecycle ---
# =====================================================
func _ready() -> void:
	# Connect dialogue events
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _physics_process(_adelta: float) -> void:
	match current_state:
		PlayerState.IDLE:
			_process_idle()
		PlayerState.MOVE:
			_process_move()
		PlayerState.DIALOGUE:
			# Player cannot move during dialogue
			velocity = Vector2.ZERO

	move_and_slide()

# =====================================================
# --- State Behaviors ---
# =====================================================
func _process_idle() -> void:
	velocity = Vector2.ZERO
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_direction != Vector2.ZERO:
		current_state = PlayerState.MOVE

func _process_move() -> void:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_direction == Vector2.ZERO:
		current_state = PlayerState.IDLE
		return
	
	velocity = input_direction * move_speed
	sprite.flip_h = velocity.x < 0

# =====================================================
# --- Dialogue Events ---
# =====================================================
func _on_dialogue_started(_resource) -> void:
	current_state = PlayerState.DIALOGUE
	velocity = Vector2.ZERO

func _on_dialogue_ended(_resource) -> void:
	# Resume idle by default
	current_state = PlayerState.IDLE
