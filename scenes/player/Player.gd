#extends Area2D
extends CharacterBody2D
@onready var sprite_2d = $Sprite2D
const MOVE_VALUE:float=900.0
@onready var engine_speed = $engineSpeed
@onready var engine_normal = $engineNormal
@onready var car_hit_sound = $carHitSound
@onready var fuel_timer = $fuelTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_player_hit.connect(on_player_hit)
	SignalManager.on_power_up.connect(on_power_up)
	
	
func _process(delta):
	move(delta) # calling move in process because we are not increasing velocity and we need instant change of position not gradual or frame by frame
	power()
	move_and_slide()
	
func power()->void:
	if not GameManager.is_in_power_mode:
		GameManager.SCROLL_SPEED=GameManager.INITIAL_SPEED
		if not engine_normal.playing:
			engine_normal.play()
		engine_speed.stop()
		
		
func on_power_up()->void:
	GameManager.SCROLL_SPEED=GameManager.POWER_SPEED
	if not engine_speed.playing:
		engine_speed.play()
	engine_normal.stop()
	fuel_timer.start()
	
			

func move(delta)->void:
	if Input.is_action_pressed("left"):
		position.x-=MOVE_VALUE*delta
	if Input.is_action_pressed("right"):
		position.x+=MOVE_VALUE*delta
		
func on_player_hit()->void:
	engine_normal.stop()
	engine_speed.stop()
	car_hit_sound.play()
	set_process(false)
		
func _on_fuel_timer_timeout():
	GameManager.is_in_power_mode=false
