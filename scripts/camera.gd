extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	global_position.x = 0
	global_position.y = get_parent().global_position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.y = get_parent().global_position.y
	global_position.x = 0
	if global_position.y >= 3000:
		global_position.y = 3000
