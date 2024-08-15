extends ParallaxBackground


# Called when the node enters the scene tree for the first time.
func _ready():
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# moving the backgrounds with scroll offset x manually because we don't have a moving 2d Camera
	scroll_offset.y += GameManager.SCROLL_SPEED * delta
