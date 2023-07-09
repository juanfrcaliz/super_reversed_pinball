extends CanvasLayer


# Actions variables.
var LEFT_COOLDOWN: float = 1
var RIGHT_COOLDOWN: float = 1
var FIST_COOLDOWN: float = 1

var HAND_APPEARANCE_TIME = 0.2

# Declare movement variables
var current_left_cooldown: float
var current_right_cooldown: float
var current_fist_cooldown: float

var left_hand_visible: float
var right_hand_visible: float
var fist_visible: float

# Called when the node enters the scene tree for the first time.
func _ready():
	current_left_cooldown = 0.0
	current_right_cooldown = 0.0
	current_fist_cooldown = 0.0
	$ManoDerecha.hide()
	$ManoIzquieda.hide()
	$Puno.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_left_cooldown > 0:
		current_left_cooldown -= delta
	if current_right_cooldown > 0:
		current_right_cooldown -= delta
	if current_fist_cooldown > 0:
		current_fist_cooldown -= delta
		
	if $ManoIzquieda.is_visible_in_tree():
		left_hand_visible -= delta
		if left_hand_visible <= 0:
			$ManoIzquieda.hide()
	
	if Input.is_action_just_pressed("left hand"):
		if current_left_cooldown <= 0:
			$ManoIzquieda.show()
			left_hand_visible = HAND_APPEARANCE_TIME
			current_left_cooldown = LEFT_COOLDOWN
			
	if $ManoDerecha.is_visible_in_tree():
		right_hand_visible -= delta
		if right_hand_visible <= 0:
			$ManoDerecha.hide()
		
	if Input.is_action_just_pressed("right hand"):
		if current_right_cooldown <= 0:
			$ManoDerecha.show()
			right_hand_visible = HAND_APPEARANCE_TIME
			current_right_cooldown = RIGHT_COOLDOWN
		
	if $Puno.is_visible_in_tree():
		fist_visible -= delta
		if fist_visible <= 0:
			$Puno.hide()
		
	if Input.is_action_just_pressed("fist"):
		if current_fist_cooldown <= 0:
			$Puno.show()
			fist_visible = HAND_APPEARANCE_TIME
			current_fist_cooldown = FIST_COOLDOWN
