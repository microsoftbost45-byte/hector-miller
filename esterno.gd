extends Node2D

func _ready():
	if GameManager.punto_spawn == "da_ufficio_a_esterno":
		$Player.global_position = $PuntoArrivoDaUfficio.global_position
	var suono = $Player.get_node("SuonoPassi")
	suono.stream = load("res://AudioSottofondocamminataNotte.wav")
	suono.play(1.15)
	suono.stop()
