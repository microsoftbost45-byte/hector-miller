extends Node2D

func _ready():
	$CanvasLayer/Musica.play(GameManager.posizione_musica)
	$CanvasLayer/BottoneMenu.pressed.connect(_on_menu_pressed)

func _on_menu_pressed():
	GameManager.posizione_musica = $CanvasLayer/Musica.get_playback_position()
	get_tree().change_scene_to_file("res://menu.tscn")
