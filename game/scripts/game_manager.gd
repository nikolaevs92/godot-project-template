extends Node

var is_paused: bool = false
var current_scene: String

const PAUSE_MENU_PRELOAD = preload("res://game/scenes/pause_menu.tscn")
var pause_menu_instance = null

const MAIN_MENU = "MAIN_MENU"
const INTRO = "INTRO"

const SCENES_PATHS = {
	MAIN_MENU: "res://game/scenes/main_menu.tscn",
	INTRO: "res://game/scenes/intro.tscn",
}

const SCENE_MUSIC_THEMES = {
	MAIN_MENU: AudioManager.MAIN_THEME,
	INTRO: AudioManager.MAIN_THEME,
}

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	

func change_scene(scene: String):
	if not SCENES_PATHS.has(scene):
		print("not scene: " + scene)
		return
	
	if not SCENE_MUSIC_THEMES.has(scene):
		print("not scene: " + scene)
		return
		
	var scene_path = SCENES_PATHS[scene]
	current_scene = scene
	
	TransitionScreen.transition()
	await TransitionScreen.transition_finished
	AudioManager.switch(SCENE_MUSIC_THEMES[scene])
	get_tree().change_scene_to_file(scene_path)
	print("Scene changed to:" + scene_path)

func _input(event):
	if event.is_action_pressed("ui_esc"):  # ESC key
		print("escape button pressed")
		print(current_scene)
		if not current_scene == MAIN_MENU:
			if is_paused:
				unpause_game()
			else:
				pause_game()
		
func save_data() -> Dictionary:
	return {
		"current_scene": current_scene,
		"game_state": GameState.state
	}
	
func load_save(saved_data: Dictionary):
	if not (saved_data.has("current_scene") and saved_data.has("game_state")):
		print("load_save error")
		return
	
	current_scene = saved_data["current_scene"]
	GameState.state = saved_data["game_state"]
	init_game()

func init_game():
	change_scene(current_scene)
	
func new_game():
	current_scene = INTRO
	init_game()	

# Function to pause the game
func pause_game():
	is_paused = true
	get_tree().paused = true
	pause_menu_instance = PAUSE_MENU_PRELOAD.instantiate()
	get_tree().root.add_child(pause_menu_instance)
	
	pause_menu_instance.reveal_menu()
	pause_menu_instance.get_tree().paused = false

# Function to unpause the game
func unpause_game():
	is_paused = false
	get_tree().paused = false
	# The pause menu will unpause itself when the Resume button is pressed
	pause_menu_instance.queue_free()
