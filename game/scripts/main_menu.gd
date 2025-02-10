extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.current_scene = GameManager.MAIN_MENU
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_new_game_button_pressed():
	start_new_game()


func _on_load_game_button_pressed():
	load_game()


func _on_exit_button_pressed():
	get_tree().quit()


func start_new_game():
	# Switch to the main game scene (e.g., "Home" scene)
	GameManager.new_game()

func load_game():
	# Load the saved game data (this will be handled later)
	# For now, just switch to the home or office scene as a placeholder
	if SaveManager.save_exist():
		SaveManager.load_game()
	else:
		print("No save game found.")

func exit_game():
	# Quit the game
	get_tree().quit()
