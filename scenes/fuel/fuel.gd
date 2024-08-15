extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_player_hit.connect(on_player_die)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed=GameManager.INITIAL_SPEED
	if(GameManager.is_in_power_mode):
		speed=speed*2
	position.y+=speed*delta


func _on_body_entered(body):
	if body.is_in_group(GameManager.GROUP_PLAYER):
		SignalManager.on_power_up.emit()
		GameManager.is_in_power_mode=true
		queue_free()

func on_player_die():
	GameManager.is_in_power_mode=false
	set_process(false)
	
