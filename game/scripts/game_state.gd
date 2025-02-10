extends Node

@onready var state: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_value(value_name: String, context: String="main", default_value: Variant=null) -> Variant: 
	return state.get(context, {}).get(value_name, default_value)
		
func set_value(value_name: String, value: Variant=null, context: String="main"): 
	if not is_json_compatible(value):
		print("ERROR")
		return
	if not state.has(context):
		state[context] = {}
	state[context][value_name] = value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func is_json_compatible(value: Variant) -> bool:
	return JSON.stringify(value) != null
