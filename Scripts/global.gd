extends Node

var save_path = "user://savedata.save"

var player_pos : Vector2
var npc_pos : Vector2
var rage_level : int
var npc_dead : bool
signal is_saving

func save_data():
	emit_signal("is_saving")
	var file = FileAccess.open(save_path, FileAccess.WRITE)	
	file.store_var(player_pos)
	file.store_var(npc_pos)
	file.store_var(rage_level)
	file.store_var(npc_dead)

func load_data():
	var file = FileAccess.open(save_path, FileAccess.READ)
	if FileAccess.file_exists(save_path):
		player_pos = file.get_var()
		npc_pos = file.get_var()
		rage_level = file.get_var()
		npc_dead = file.get_var()
	else:
		player_pos = Vector2(2, -24)
		rage_level = 0
		npc_dead = false
