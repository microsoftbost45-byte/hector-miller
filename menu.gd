extends Node2D

func _ready():
	$CanvasLayer/BottoneGioca.pressed.connect(_on_gioca_pressed)
	$CanvasLayer/Musica.play(GameManager.posizione_musica)

func _on_gioca_pressed():
	GameManager.bersaglio1_morto = false
	GameManager.bersaglio2_morto = false
	GameManager.posizione_musica = $CanvasLayer/Musica.get_playback_position()
	get_tree().change_scene_to_file("res://esterno.tscn")
