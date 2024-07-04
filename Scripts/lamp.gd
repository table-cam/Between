extends StaticBody2D

var player_in_area = false
@onready var body_player : CharacterBody2D = null


func _on_interact_area_body_entered(body):
	if body.is_in_group("player"):
		body_player = body
		player_in_area = true



func _on_interact_area_body_exited(body):
	if body.is_in_group("player"):
		body_player = null
		player_in_area = false

func _process(_delta):
	if body_player != null && player_in_area == true:
			body_player.bloodBar.value += 1
