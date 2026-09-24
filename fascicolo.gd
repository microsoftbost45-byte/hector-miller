extends Area2D

var giocatore_vicino = false
var foto_aperta = false
var sequenza_id = 0

func _ready():
	process_priority = -10
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	%BottoneX.pressed.connect(chiudi_foto)

func _on_body_entered(body):
	if body.is_in_group("player"):
		giocatore_vicino = true
		$Suggerimento.visible = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		giocatore_vicino = false
		$Suggerimento.visible = false

func _process(_delta):
	if giocatore_vicino and Input.is_action_just_pressed("interagisci") and not foto_aperta:
		GameManager.blocco_input = true
		apri_foto()

func apri_foto():
	foto_aperta = true
	$Suggerimento.visible = false
	%FotoGrande.visible = true
	%BottoneX.visible = true
	%Scritta.text = ""
	get_node("../HUD").visible = false
	get_tree().paused = true
	sequenza_id += 1
	$SuonoVoce.play()
	mostra_scritte(sequenza_id)

func mostra_scritte(mio_id):
	await get_tree().create_timer(2.0).timeout
	if mio_id != sequenza_id or not foto_aperta:
		return
	%Scritta.text = "Wait..."
	await get_tree().create_timer(3.0).timeout
	if mio_id != sequenza_id or not foto_aperta:
		return
	%Scritta.text = "Laura..."
	await get_tree().create_timer(2.7).timeout
	if mio_id != sequenza_id or not foto_aperta:
		return
	%Scritta.text = "Those bastards!"

func chiudi_foto():
	sequenza_id += 1
	foto_aperta = false
	%FotoGrande.visible = false
	%BottoneX.visible = false
	%Scritta.text = ""
	get_node("../HUD").visible = true
	get_tree().paused = false
	$SuonoVoce.stop()
	await get_tree().create_timer(0.3).timeout
	GameManager.blocco_input = false
