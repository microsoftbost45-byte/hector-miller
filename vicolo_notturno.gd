extends Node2D

func _ready():
	if GameManager.punto_spawn == "da_ufficio":
		$Player.global_position = $PuntoArrivoDaUfficio.global_position
	elif GameManager.punto_spawn == "da_terza":
		$Player.global_position = $PuntoArrivoDaTerza.global_position
	elif GameManager.punto_spawn == "da_seconda":
		$Player.global_position = $PuntoArrivoDaSeconda.global_position
