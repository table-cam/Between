extends Node2D

@onready var TransitionColor = $CanvasLayer/TransitionScene/ColorRect
@onready var TransitionAnim = $CanvasLayer/TransitionScene/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	TransitionColor.color.a = 255
	TransitionAnim.play("fade_out")
	$Player.global_position = Global.player_pos
	$Player.bloodBar.value = Global.rage_level


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
