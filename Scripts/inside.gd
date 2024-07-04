extends Node2D

@onready var TransitionColor = $CanvasLayer/TransitionScene/ColorRect
@onready var TransitionAnim = $CanvasLayer/TransitionScene/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	TransitionColor.color.a = 255
	TransitionAnim.play("fade_out")
	$Player.bloodBar.value = Global.rage_level


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_change_scene_area_body_entered(body):
	if body.is_in_group("player"):
		TransitionAnim.play("fade_in")
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Scenes/main.tscn")
