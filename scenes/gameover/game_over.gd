extends Control
@onready var go_label = $MarginContainer/goLabel
@onready var space_label = $MarginContainer/pressSpace
@onready var timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	hide() # hiding entire GameoverScene initially
	SignalManager.on_player_hit.connect(on_game_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if space_label.visible and Input.is_action_just_pressed("power"):
		SceneManager.load_main_scene()


func _on_timer_timeout()->void:
	go_label.hide()
	space_label.show()


func on_game_over()->void:
	show()
	timer.start()
	
