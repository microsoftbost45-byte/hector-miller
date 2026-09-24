extends CanvasLayer

func _ready():
	$BottoneSinistra.button_down.connect(_on_sinistra_down)
	$BottoneSinistra.button_up.connect(_on_sinistra_up)
	$BottoneDestra.button_down.connect(_on_destra_down)
	$BottoneDestra.button_up.connect(_on_destra_up)
	$BottoneInteragisci.button_down.connect(_on_interagisci)
	$BottoneSalto.button_down.connect(_on_salto)

func get_player():
	return get_tree().get_first_node_in_group("player")

func _on_sinistra_down():
	get_player().muovi_sinistra = true

func _on_sinistra_up():
	get_player().muovi_sinistra = false

func _on_destra_down():
	get_player().muovi_destra = true

func _on_destra_up():
	get_player().muovi_destra = false

func _on_interagisci():
	Input.action_press("interagisci")
	await get_tree().create_timer(0.1).timeout
	Input.action_release("interagisci")

func _on_salto():
	Input.action_press("ui_accept")
	await get_tree().create_timer(0.1).timeout
	Input.action_release("ui_accept")
