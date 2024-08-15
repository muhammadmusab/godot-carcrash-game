extends Node2D
@onready var area_2d = $Area2d


@onready var score_sound = $scoreSound

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_player_hit.connect(_on_player_die)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed=GameManager.INITIAL_SPEED
	if(GameManager.is_in_power_mode):
		speed=speed*2
	position.y+=speed*delta


func _on_player_die():
	set_process(false)
	

func _on_body_entered(body):
	if body.is_in_group(GameManager.GROUP_PLAYER):
		score_sound.play()
		if GameManager.is_in_power_mode:
			ScoreManager.set_score(5)
		else:
			ScoreManager.set_score(1)
		SignalManager.on_coin_collect.emit()
		area_2d.queue_free()
		


func _on_score_sound_finished():
	queue_free()
