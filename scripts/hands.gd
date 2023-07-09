extends CanvasLayer


var HAND_APPEARANCE_TIME = 0.3

var left_hand_visible: float
var right_hand_visible: float
var fist_visible: float

# Called when the node enters the scene tree for the first time.
func _ready():
	$ManoDerecha.hide()
	$ManoIzquieda.hide()
	$Puno.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $ManoIzquieda.is_visible_in_tree():
		left_hand_visible -= delta
		if left_hand_visible <= 0:
			$ManoIzquieda.hide()
	
	if Input.is_action_just_pressed("left hand"):
		$ManoIzquieda.show()
		left_hand_visible = HAND_APPEARANCE_TIME
			
	if $ManoDerecha.is_visible_in_tree():
		right_hand_visible -= delta
		if right_hand_visible <= 0:
			$ManoDerecha.hide()
		
	if Input.is_action_just_pressed("right hand"):
		$ManoDerecha.show()
		right_hand_visible = HAND_APPEARANCE_TIME
		
	if $Puno.is_visible_in_tree():
		fist_visible -= delta
		if fist_visible <= 0:
			$Puno.hide()
		
	if Input.is_action_just_pressed("fist"):
		$Puno.show()
		fist_visible = HAND_APPEARANCE_TIME
