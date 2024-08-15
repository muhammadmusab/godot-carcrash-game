extends Node
@onready var score_label = $MarginContainer/Score_Label


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_coin_collect.connect(on_coin_collect)


func on_coin_collect()->void:
	score_label.text=str(ScoreManager.get_score())
	
