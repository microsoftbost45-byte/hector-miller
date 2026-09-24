extends Node

var player: AudioStreamPlayer

func _ready():
	player = AudioStreamPlayer.new()
	player.stream = load("res://menusound.wav")
	player.name = "MusicaMenu"
	add_child(player)

func suona():
	if not player.playing:
		player.play()

func ferma():
	if player.playing:
		player.stop()
