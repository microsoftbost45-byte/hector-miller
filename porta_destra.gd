extends Area2D

var giocatore_vicino = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("player"):
		giocatore_vicino = true
		$Label.visible = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		giocatore_vicino = false
		$Label.visible = false

func _process(_delta):
	if giocatore_vicino and Input.is_action_just_pressed("interagisci"):
		GameManager.punto_spawn = "da_esterno"
		get_tree().call_deferred("change_scene_to_file", "res://ufficio_forense.tscn")
