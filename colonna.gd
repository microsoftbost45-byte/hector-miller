extends Area2D

var nascosto = false
var player_ref = null

func _ready():
	add_to_group("colonna")
	player_ref = get_tree().get_first_node_in_group("player")

func _process(_delta):
	if player_ref == null:
		player_ref = get_tree().get_first_node_in_group("player")
		return
	nascosto = overlaps_body(player_ref)
