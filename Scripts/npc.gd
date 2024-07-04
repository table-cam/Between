extends CharacterBody2D

@onready var Sprite = $AnimatedSprite2D
@onready var path_follow = get_parent()

@export var dialog_file : DialogueResource
@export var dialog_start : String = "this_is_a_node_title"
const Balloon = preload("res://Scenes/balloon.tscn")

const SPEED = 50
var npc_dead : bool
var is_talking : bool = false
var last_pos : Vector2
var direction : Vector2

func _ready():
	DialogueManager.dialogue_ended.connect(_on_dialogue_manager_dialogue_ended)
	npc_dead = Global.npc_dead
	update_animation()
	if npc_dead:
		global_position = Global.npc_pos
	

func _on_death_cutscene_dead():
	Sprite.play("dead")
	
func update_animation():
	if(npc_dead == true):
		Sprite.play("dead")
	else:
		if direction == Vector2.ZERO:
			Sprite.play("idle")
		else:
			if direction.x > 0:
				Sprite.play("right")
			if direction.x < 0:
				Sprite.play("left")
			if direction.y > 0:
				Sprite.play("down")
			if direction.y < 0:
				Sprite.play("up")
		

func _physics_process(delta):
	if path_follow is PathFollow2D && npc_dead == false && is_talking == false:
		last_pos = global_position
		path_follow.set_progress(path_follow.get_progress() +(SPEED * delta))
		move_and_slide()
		direction = global_position - last_pos
		update_animation()

func _on_death_cutscene_death_cutscene_starts():
	npc_dead = true
	Global.npc_dead = npc_dead
	Global.npc_pos = global_position
	Sprite.play("idle")


func _on_talk_area_body_entered(body):
	if npc_dead == false && body.is_in_group("player") && body.rage_mode == false:
		body.npc = self


func _on_talk_area_body_exited(body):
	if npc_dead == false && body.is_in_group("player") && body.rage_mode == false:
		body.npc = null

func talk(body):
	body.can_move = false
	is_talking = true
	Sprite.play("idle")
	var balloon = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialog_file, dialog_start)

func _on_dialogue_manager_dialogue_ended(_resource: DialogueResource):
	is_talking = false
