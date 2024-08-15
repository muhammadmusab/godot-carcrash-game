extends Node2D
@onready var enemy_spawn_timer = $EnemySpawnTimer
@onready var enemy_holder = $EnemyHolder
@onready var mark_holder = $MarkHolder
@export var enemies:Array[PackedScene]
@export var coins:Array[PackedScene]
@export var fuel:PackedScene
@onready var parallax_bg = $CanvasLayer/ParallaxBg
@onready var coin_holder = $CoinHolder
@onready var coin_timer = $CoinTimer
@onready var fuel_spawn_timer = $FuelSpawnTimer
@onready var fuel_holder = $FuelHolder


var marks=[]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	SignalManager.on_player_hit.connect(on_game_over)
	marks=mark_holder.get_children()
	ScoreManager.reset_score()
	GameManager.ENEMEY_SPEED=GameManager.INITIAL_ENEMY_SPEED
	GameManager.SCROLL_SPEED=GameManager.INITIAL_SPEED
	GameManager.is_in_power_mode=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_spawn_timer_timeout()->void:
	spawn_enemy()
	
func _on_coin_timer_timeout():
	spawn_coin()


func on_game_over()->void:
	enemy_spawn_timer.stop()
	coin_timer.stop()
	fuel_spawn_timer.stop()
	GameManager.ENEMEY_SPEED=0
	GameManager.SCROLL_SPEED=0
	GameManager.is_in_power_mode=false
	ScoreManager.reset_score()
	#stop sounds of existing enemies on game over
	for enemy in enemy_holder.get_children():
		enemy.get_child(-1).stop()
	
	


func spawn_coin()->void:
	var position_index=randi_range(0,marks.size()-1)
	var spawnPosition=marks[position_index]
	var coin_index=0
	var coin=coins[coin_index]
	var new_coin=coin.instantiate()
	new_coin.position=Vector2(spawnPosition.position.x,spawnPosition.position.y)
	coin_holder.add_child(new_coin)
	
func spawn_enemy()->void:
	var number_of_enemies=randi_range(1,2)
	var current_position_index:int
	for n in number_of_enemies:
		var position_index=randi_range(0,marks.size()-1)
		var spawnPosition=marks[position_index]
		var enemy_index=randi_range(0,enemies.size()-1)
		var enemy=enemies[enemy_index]
		var new_enemy=enemy.instantiate()
		if position_index==current_position_index and position_index<marks.size()-1:
			position_index+=1
		spawnPosition=marks[position_index]
		var enemy_position_y=spawnPosition.position.y
		if(n==1):
			enemy_position_y=enemy_position_y-450.0
		new_enemy.position=Vector2(spawnPosition.position.x,enemy_position_y)
		enemy_holder.add_child(new_enemy)
		current_position_index=position_index

	
func spawn_fuel()->void:
	var position_index=randi_range(0,marks.size()-1)
	var spawnPosition=marks[position_index]
	var new_fuel=fuel.instantiate()
	new_fuel.position=Vector2(spawnPosition.position.x,spawnPosition.position.y)
	fuel_holder.add_child(new_fuel)
		




func _on_fuel_spawn_timer_timeout():
	spawn_fuel()
