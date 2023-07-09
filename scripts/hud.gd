extends CanvasLayer


signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_node("ScoreScreen").visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("ScoreLabel").text = str(get_parent().get_parent().get_max_score())


func _on_button_pressed():
	#$Label.hide()
	#$Label2.hide()
	#$Button.hide()
	#$Sprite2D.hide()
	visible = false
	var ball = get_parent().get_parent()
	ball.init_ball()
	ball.in_main_menu = false
	get_parent().get_node("ScoreScreen").visible = true
