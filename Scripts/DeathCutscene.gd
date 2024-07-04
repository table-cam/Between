extends Node2D

@onready var Particles = $CPUParticles2D
@onready var ParticleTimer = $CPUParticles2D/Timer
@onready var AnimationBars = $AnimationPlayer
@onready var UpBar = $CanvasLayer/UpBar
@onready var DownBar = $CanvasLayer/DownBar
@onready var body_player : CharacterBody2D = null

signal Dead()
signal DeathCutsceneStarts()
var dead : bool

func _ready():
	AnimationBars.play("RESET")

func die():
	body_player.can_move = false
	emit_signal("DeathCutsceneStarts")
	UpBar.visible = true
	DownBar.visible = true
	AnimationBars.play("black_bars_in")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "black_bars_in":
		Particles.emitting = true
		ParticleTimer.start()
	elif anim_name == "black_bars_out":
		body_player.can_move = true
	

func _on_timer_timeout():
	emit_signal("Dead")
	Particles.emitting = false
	AnimationBars.play("black_bars_out")
	

func _on_interact_area_body_entered(body):
	if body.is_in_group("player"):
		body_player = body
		dead = Global.npc_dead
		if body_player.rage_mode == true && dead == false:
			body_player.bloodBar.value = 0
			body_player.rage_mode = false
			dead = true
			die()
