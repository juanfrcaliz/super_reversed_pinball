extends StaticBody2D

var TIME_SHOWING_HIT_SCORE: float = 1.0;
var current_time_hit: float = 0.0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_time_hit > 0.0:
		get_node("HitLabel").visible = true
	else:
		get_node("HitLabel").visible = false
	
	current_time_hit -= delta
	if current_time_hit < 0.0:
		current_time_hit = 0.0
		
func hit(points: String):
	get_node("HitLabel").text = points
	current_time_hit = TIME_SHOWING_HIT_SCORE
