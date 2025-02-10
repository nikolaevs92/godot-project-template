extends CanvasLayer

signal transition_finished

@onready var color_rect = $ColorRect
@onready var anim_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	color_rect.visible = false
	anim_player.animation_finished.connect(_on_animation_finished)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func transition():
	color_rect.visible = true
	anim_player.play("fade_to_black")
	
func _on_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		transition_finished.emit()
		anim_player.play("black_to_fade")
	elif anim_name == "black_to_fade":
		color_rect.visible = false
