extends CharacterBody2D

const VELOCITA = 80.0
const DISTANZA_VISTA = 250.0
var direzione = 1
var punto_a: Vector2
var punto_b: Vector2
var in_pausa = false
var giocatore_in_zona_azione = false
var player_ref = null
var scoperto = false

func _ready():
	if GameManager.bersaglio1_morto:
		queue_free()
		return
	punto_a = $"../PuntoA".global_position
	punto_b = $"../PuntoB".global_position
	$ZonaAzione.body_entered.connect(_on_zona_azione_entered)
	$ZonaAzione.body_exited.connect(_on_zona_azione_exited)
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	if not in_pausa and not scoperto:
		velocity.x = VELOCITA * direzione
		if direzione == 1 and global_position.x >= punto_b.x:
			pausa(1)
		elif direzione == -1 and global_position.x <= punto_a.x:
			pausa(-1)
		else:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = direzione == -1
			if not $SuonoPassi.playing:
				$SuonoPassi.play(1.30)
	else:
		velocity.x = 0
		if $SuonoPassi.playing:
			$SuonoPassi.stop()
	move_and_slide()

func pausa(nuova_direzione):
	in_pausa = true
	$AnimatedSprite2D.play("special")
	await $AnimatedSprite2D.animation_finished
	$AnimatedSprite2D.play("idle")
	await get_tree().create_timer(1.0).timeout
	direzione = nuova_direzione * -1
	$Visuale.scale.x = nuova_direzione * -1
	$ZonaAzione.scale.x = nuova_direzione * -1
	in_pausa = false

func player_nascosto() -> bool:
	for colonna in get_tree().get_nodes_in_group("colonna"):
		if colonna.nascosto:
			return true
	return false

func _process(_delta):
	if player_ref == null:
		player_ref = get_tree().get_first_node_in_group("player")
		return

	if not scoperto:
		var distanza = global_position.distance_to(player_ref.global_position)
		var diff_x = player_ref.global_position.x - global_position.x
		var player_davanti = (direzione == 1 and diff_x > 0) or (direzione == -1 and diff_x < 0)

		if distanza < DISTANZA_VISTA and player_davanti and not player_nascosto():
			scoperto = true
			scopri_player()

	if giocatore_in_zona_azione and in_pausa and Input.is_action_just_pressed("interagisci"):
		applica_il_codice()

func scopri_player():
	$SuonoScoperto.play(0.5)
	$AnimatedSprite2D.play("special")
	while $AnimatedSprite2D.frame < 3:
		await get_tree().process_frame
	$AnimatedSprite2D.pause()
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://game_over.tscn")

func _on_zona_azione_entered(body):
	if body.is_in_group("player"):
		giocatore_in_zona_azione = true

func _on_zona_azione_exited(body):
	if body.is_in_group("player"):
		giocatore_in_zona_azione = false

func applica_il_codice():
	set_physics_process(false)
	set_process(false)
	GameManager.bersaglio1_morto = true
	await get_tree().create_timer(0.7).timeout
	$AnimatedSprite2D.play("death")
	await $AnimatedSprite2D.animation_finished
	%Messaggio.text = "Justice served."
	queue_free()
