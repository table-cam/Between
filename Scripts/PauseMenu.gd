extends Control

@onready var save_label = $PanelContainer/VBoxContainer/Label

func resume():
	get_tree().paused = false
	save_label.text = ""
	visible = false
	
func pause():
	get_tree().paused = true
	visible = true

func _on_resume_button_pressed():
	resume()
	
func _on_save_button_pressed():
	Global.save_data()
	save_label.text = "saved !"

func _on_quit_button_pressed():
	get_tree().quit()

func testPause():
	if Input.is_action_just_pressed("esc"):
		if get_tree().paused == false:
			pause()
		else:
			resume()
			
func _ready():
	visible = false
	
func _physics_process(_delta):
	testPause()



