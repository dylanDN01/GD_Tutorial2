extends Area2D

var player = null
var distance = 0
var movespeed = 5

func _ready():
	modulate = Color(1.0, 0.2, 0.2)

# player chasing movement
func _process(delta):
	if (player != null):
		look_at(player.position)
		distance = (player.position - position)
		
		# pythagorean formula
		if (sqrt(distance.x**2 + distance.y**2) > 200 and sqrt(distance.x**2 + distance.y**2) < 800):
			position += distance.normalized() * movespeed

# detection (child area2d)
func _on_detection_range_body_entered(body):
	if body.is_in_group("Player"):
		player = body

# collision (main area2d)
func _on_body_entered(body):
	queue_free()
