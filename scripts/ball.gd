extends RigidBody2D

# Ball behavior constants.
var IMPULSE_X: float = 400.0
var IMPULSE_Y: float = -40.0

# Actions variables.
var LEFT_COOLDOWN: float = 1
var RIGHT_COOLDOWN: float = 1
var FIST_COOLDOWN: float = 1
var JUMP_DURATION: float = 0.5

# Game start
var INITIAL_IMPULSE: float = -2000
var INITIAL_POSITION_X = 1306
var INITIAL_POSITION_Y = 3458

# Declare movement variables
var current_left_cooldown: float
var current_right_cooldown: float
var current_fist_cooldown: float
var jump_time: float

# Game state.
var start: bool = true
var in_main_menu: bool = true
var GAME_OVER_DURATION: float = 50
var game_over: bool = false
var game_over_countdown: int

# Number of balls.
var MAX_LIVES: int = 3
var current_lives: int = MAX_LIVES

# Score
var POINT_PER_HIT: int = 30
var INITIAL_SCORE: int = 1000
var current_score = INITIAL_SCORE
var max_score: int = 0


func decrease_lives():
	current_lives -= 1
	if current_lives == 2:
		get_node("Camera2D/ScoreScreen/Live3").visible = false
	if current_lives == 1:
		get_node("Camera2D/ScoreScreen/Live2").visible = false
	if current_lives == 0:
		get_node("Camera2D/ScoreScreen/Live1").visible = false
		get_node("Camera2D/ScoreScreen").visible = false
		get_node("Camera2D/CanvasLayer").visible = true
		if current_score > max_score:
			max_score = current_score
		in_main_menu = true


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.hide()
	current_left_cooldown = 0.0
	current_right_cooldown = 0.0
	current_fist_cooldown = 0.0
	jump_time = 0.0


func _on_body_entered(body):
	
	if body.name == "goal":
		start = true
		global_position.x = INITIAL_POSITION_X
		global_position.y = INITIAL_POSITION_Y
		decrease_lives()
		
	elif body.name == "start":
		start = true
		
	elif body.name != "table":
		current_score -= POINT_PER_HIT
		body.hit(str(-POINT_PER_HIT))
		$obstacle.play()
		if current_score <= 0:
			set_freeze_enabled(true)
			$Explosion.show()
			game_over = true
			game_over_countdown = GAME_OVER_DURATION


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_over:
		game_over_countdown -= delta
		if game_over_countdown <= 0:
			get_node("Camera2D/ScoreScreen/Live1").visible = false
			get_node("Camera2D/ScoreScreen").visible = false
			get_node("Camera2D/CanvasLayer").visible = true
			if current_score > max_score:
				max_score = current_score
			in_main_menu = true
			game_over = false
			$Explosion.hide()
	
	if in_main_menu:
		return
		
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
			$start.play()
			
	if Input.is_action_just_pressed("left hand"):
		if current_left_cooldown <= 0.0:
			apply_impulse(Vector2(-IMPULSE_X, IMPULSE_Y))
			current_left_cooldown = LEFT_COOLDOWN
			$hit.play()
			
	if Input.is_action_just_pressed("right hand"):
		if current_right_cooldown <= 0.0:
			apply_impulse(Vector2(IMPULSE_X, IMPULSE_Y))
			current_right_cooldown = RIGHT_COOLDOWN
			$hit.play()
			
	if Input.is_action_just_pressed("fist"):
		if current_fist_cooldown <= 0.0:
			$Icon.hide()
			$Sprite2D.show()
			set_collision_mask_value(3, false)
			apply_impulse(Vector2(0, IMPULSE_Y/10))
			current_fist_cooldown = FIST_COOLDOWN
			jump_time = JUMP_DURATION
			$hit.play()
			
	if jump_time <= 0:
		$Icon.show()
		$Sprite2D.hide()
		set_collision_mask_value(3, true)
		
func init_ball():
	game_over = false
	current_left_cooldown = 0.0
	current_right_cooldown = 0.0
	current_fist_cooldown = 0.0
	jump_time = 0.0
	current_lives = MAX_LIVES
	current_score = INITIAL_SCORE
	start = true
	global_position.x = INITIAL_POSITION_X
	global_position.y = INITIAL_POSITION_Y
	get_node("Camera2D/ScoreScreen/Live1").visible = true
	get_node("Camera2D/ScoreScreen/Live2").visible = true
	get_node("Camera2D/ScoreScreen/Live3").visible = true
	
func get_max_score():
	return max_score
