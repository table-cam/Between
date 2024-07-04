extends CharacterBody2D


const SPEED = 200.0
@onready var animationSprite = $AnimatedSprite2D
@onready var bloodBar = $CanvasLayer/BloodBar
@onready var label = $Label
@onready var can_move = true
@onready var last_x = 1

var rage_mode = false
var direction : Vector2

var house = null : set = set_house
var npc = null : set = set_npc

func set_house(new_house):
	if new_house != null:
		label.text = "E to enter"
		label.visible = true
	else:
		label.visible = false
	house = new_house

func set_npc(new_npc):
	if new_npc != null:
		label.text = "E to talk"
		label.visible = true
	else:
		label.visible = false
	npc = new_npc

func save_stats():
	Global.player_pos = global_position
	Global.rage_level = bloodBar.value

func _unhandled_input(event):
	if event is InputEventKey and event.is_action_pressed("interact"):
		if house != null:
			save_stats()
			house.enter()
		elif npc != null:
			npc.talk(self)

func _ready():
	DialogueManager.dialogue_ended.connect(_on_dialogue_manager_dialogue_ended)
	label.text = "E"
	set_house(null)

func check_rage():
	if bloodBar.value == bloodBar.max_value:
		rage_mode = true
		
func update_animation():
	if velocity == Vector2.ZERO || can_move == false:
		if last_x > 0:
			animationSprite.play("idle_right")
		else:
			animationSprite.play("idle_left")
	else:
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				animationSprite.play("walk_right")
			else:
				animationSprite.play("walk_left")
	if rage_mode == true:
		animationSprite.modulate = Color(1, 0.3, 0.3, 1)
	else:
		animationSprite.modulate = Color(1, 1, 1, 1)
				

func _physics_process(_delta):
	if can_move == true:
		if direction.x:
			last_x = direction.x
		direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		velocity = direction * SPEED
		check_rage()
		move_and_slide()
	else:
		velocity = Vector2.ZERO
	update_animation()

func _on_dialogue_manager_dialogue_ended(_resource: DialogueResource):
	can_move = true
