extends Area2D
@onready var sound = $sound

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed=GameManager.ENEMEY_SPEED
	if(GameManager.is_in_power_mode):
		speed=speed*2
	position.y+=speed*delta


func _on_body_entered(body):
	if body.is_in_group(GameManager.GROUP_PLAYER):
		set_process(false)
		SignalManager.on_player_hit.emit()
		


func _on_screen_exit():
	queue_free()
	
	

	
