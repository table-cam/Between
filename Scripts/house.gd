extends StaticBody2D

@export var inside_scene = PackedScene.new()
@onready var TransitionAnim = $CanvasLayer/TransitionScene/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_enter_house_area_body_entered(body):
	if body.is_in_group("player"):
		body.house = self


func _on_enter_house_area_body_exited(body):
	if body.is_in_group("player"):
		body.house = null

func enter():
	TransitionAnim.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_packed(inside_scene)
