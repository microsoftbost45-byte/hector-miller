extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -500.0
var muovi_sinistra = false
var muovi_destra = false
var attaccando = false

func _ready():
	add_to_group("player")
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += get_gravity().y * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = 0
	if Input.is_action_pressed("ui_left") or muovi_sinistra:
		direction = -1
	if Input.is_action_pressed("ui_right") or muovi_destra:
		direction = 1

	if direction != 0:
		velocity.x = direction * SPEED
		if not attaccando:
			if is_on_floor():
				$AnimatedSprite2D.play("walk")
			else:
				$AnimatedSprite2D.play("jump")
			$AnimatedSprite2D.flip_h = direction == -1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if not attaccando:
			if is_on_floor():
				$AnimatedSprite2D.play("idle")
			else:
				$AnimatedSprite2D.play("jump")

	if is_on_floor() and direction != 0:
		if not $SuonoPassi.playing:
			$SuonoPassi.play(1.30)
	else:
		if $SuonoPassi.playing:
			$SuonoPassi.stop()

	move_and_slide()

func _process(_delta):
	if Input.is_action_just_pressed("interagisci") and not attaccando and not get_tree().paused and not GameManager.blocco_input:
		esegui_attacco()

func esegui_attacco():
	attaccando = true
	var attacchi = ["attacco1", "attacco2", "attacco3"]
	var attacco = attacchi[randi() % attacchi.size()]
	$AnimatedSprite2D.play(attacco)
	await get_tree().create_timer(0.6).timeout
	$SuonoUccisione.play()
	await $AnimatedSprite2D.animation_finished
	attaccando = false

func morte() -> void:
	set_process(false)
	set_physics_process(false)
	$SuonoPassi.stop()
	$AnimatedSprite2D.play("hurt")
	await $AnimatedSprite2D.animation_finished
	$AnimatedSprite2D.play("morte")
	await $AnimatedSprite2D.animation_finished
	get_tree().change_scene_to_file("res://game_over.tscn")
