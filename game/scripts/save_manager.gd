extends Node

var save_file_path = "user://save_game.save"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_mode = Node.PROCESS_MODE_ALWAYS

		
func save_exist() -> bool:
	return FileAccess.file_exists(save_file_path)		

# Save the current location and time spent in the game
func save_game() -> void:
	var saved_data = GameManager.save_data()

	# Open the file in write mode
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	
	if file:
		# Store the data as JSON
		file.store_string(JSON.stringify(saved_data))
		file.close()
		print("Game saved successfully!")
	else:
		print("Failed to open file for saving.")

# Load the saved data (returns the current scene and time spent)
func load_game():
	if FileAccess.file_exists(save_file_path):
		var file = FileAccess.open(save_file_path, FileAccess.READ)
		var json_data = file.get_as_text()
		
		var json = JSON.new()
		var parse_result = json.parse(json_data)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_data, " at line ", json.get_error_line())
		var saved_data = json.data
		
		file.close()

		GameManager.load_save(saved_data)
		print("Game loaded successfully!")
