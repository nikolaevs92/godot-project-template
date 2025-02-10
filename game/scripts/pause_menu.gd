extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_resume_button_pressed():
	print("PauseMenu: resume button pressed")
	GameManager.unpause_game()

func _on_save_game_button_pressed():
	print("PauseMenu: save button pressed")
	SaveManager.save_game()
	GameManager.unpause_game()

func _on_load_game_button_pressed():
	print("PauseMenu: load button pressed")
	SaveManager.load_game()
	GameManager.unpause_game()

func _on_exit_to_main_menu_button_pressed():
	print("PauseMenu: exit to main menu button pressed")
	GameManager.change_scene("MAIN_MENU")
	GameManager.unpause_game()
	
func hide_menu():
	$Menu.visible = false
	
func reveal_menu():
	set_as_top_level(true)
	$Menu.visible = true
