extends RigidBody2D

# Ball behavior constants.
var IMPULSE_X: float = 400.0
var IMPULSE_Y: float = -40.0

# Actions variables.
var LEFT_COOLDOWN: float = 1
var RIGHT_COOLDOWN: float = 1
var FIST_COOLDOWN: float = 1
var JUMP_DURATION: float = 1.1

# Game start
var INITIAL_IMPULSE: float = -2000
var INITIAL_POSITION_X = 1306
var INITIAL_POSITION_Y = 3458

# Declare movement variables
var current_left_cooldown: float
var current_right_cooldown: float
var current_fist_cooldown: float
var jump_time: float

var start: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	current_left_cooldown = 0.0
	current_right_cooldown = 0.0
	current_fist_cooldown = 0.0
	jump_time = 0.0


func _on_body_entered(body):
	if body.name == "goal":
		start = true
		global_position.x = INITIAL_POSITION_X
		global_position.y = INITIAL_POSITION_Y
		
	if body.name == "start":
		start = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_left_cooldown > 0:
		current_left_cooldown -= delta
	if current_right_cooldown > 0:
		current_right_cooldown -= delta
	if current_fist_cooldown > 0:
		current_fist_cooldown -= delta
	if jump_time > 0:
		jump_time -= delta
		
		
	if Input.is_action_just_pressed("start"):
		if start:
			start = false
			apply_impulse(Vector2(0, INITIAL_IMPULSE))
			
	if Input.is_action_just_pressed("left hand"):
		if current_left_cooldown <= 0.0:
			apply_impulse(Vector2(-IMPULSE_X, IMPULSE_Y))
			current_left_cooldown = LEFT_COOLDOWN
			
	if Input.is_action_just_pressed("right hand"):
		if current_right_cooldown <= 0.0:
			apply_impulse(Vector2(IMPULSE_X, IMPULSE_Y))
			current_right_cooldown = RIGHT_COOLDOWN
			
	if Input.is_action_just_pressed("fist"):
		if current_fist_cooldown <= 0.0:
			set_collision_mask_value(3, false)
			apply_impulse(Vector2(0, IMPULSE_Y/10))
			current_fist_cooldown = FIST_COOLDOWN
			jump_time = JUMP_DURATION
			
	if jump_time <= 0:
		set_collision_mask_value(3, true)
