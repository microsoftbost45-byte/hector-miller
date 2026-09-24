extends Node2D

func _ready():
	if GameManager.punto_spawn == "da_vicolo":
		$Player.global_position = $PuntoArrivoDaVicolo.global_position
	elif GameManager.punto_spawn == "da_esterno":
		$Player.global_position = $PuntoArrivoDaEsterno.global_position
