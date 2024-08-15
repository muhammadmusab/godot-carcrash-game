extends ParallaxLayer
@onready var sprite_2d = $Sprite2D

@export var texture:Texture 
@export var scroll_scale:float=0.0 
@export var texture_x:float=600.0
@export var texture_y:float=465.0


func _ready():
	motion_scale.x=scroll_scale
	var scale_factor=0.714
	sprite_2d.scale=Vector2(scale_factor,scale_factor)
	sprite_2d.texture=texture
	
	motion_mirroring.y=texture_y

func _process(delta):
	pass
