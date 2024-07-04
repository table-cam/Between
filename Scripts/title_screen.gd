extends Control

@onready var Transition = $TransitionScene
@onready var TransitionAnim = $TransitionScene/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_load_game_pressed():
	pass # Replace with function body.


func _on_new_game_pressed():
	Transition.visible = true;
	TransitionAnim.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_controls_pressed():
	pass # Replace with function body.
