# SoundManager.gd
extends Node

@export var music_volume: float = 0.3
@export var sfx_volume: float = 1.0

var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

const MAIN_THEME = "res://game/assets/music/..."

var current = ""

func _ready():
	# Create AudioStreamPlayers for music and sfx if they don't exist
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	
	sfx_player = AudioStreamPlayer.new()
	add_child(sfx_player)
	
	# Set initial volumes
	music_player.volume_db = linear_to_db(music_volume)
	sfx_player.volume_db = linear_to_db(sfx_volume)
	
	play_music(MAIN_THEME)
	music_player.process_mode = AudioStreamPlayer.PROCESS_MODE_ALWAYS

func play_music(audio_name: String):
	current = audio_name
	music_player.stream = load(current)
	music_player.play()

func switch(audio_name: String):
	if current == audio_name:
		return
	stop_music()
	play_music(audio_name)

func stop_music():
	current = ""
	music_player.stop()

func play_sfx(sfx_name: String):
	sfx_player.stream = load(sfx_name)
	sfx_player.play()

func set_music_volume(volume: float):
	music_volume = volume
	music_player.volume_db = linear_to_db(volume)

func set_sfx_volume(volume: float):
	sfx_volume = volume
	sfx_player.volume_db = linear_to_db(volume)

# Optional: Fade music in/out if needed
func fade_out_music(duration: float):
	music_player.fade_out(duration)

func fade_in_music(stream: AudioStream, duration: float):
	music_player.stream = stream
	music_player.play()
	music_player.fade_in(duration)
