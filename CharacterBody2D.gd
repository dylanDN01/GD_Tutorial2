extends CharacterBody2D

var speed = 500

# tutorial
@onready var sprite = $Sprite2D	

func _physics_process(delta):
	
	# Tutorial
	sprite.look_at(get_global_mouse_position())
	
	if (Input.is_action_just_pressed("mouse_click_left")):
		create_projectile(sprite.rotation)
	
	# 8 direction movement (saves time; works same as if statements)
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * speed
	move_and_slide()
	
# rigid bodies, rotation, etc
func create_projectile(direction):
	
	var bullet = RigidBody2D.new()
	var bullet_image = Sprite2D.new()
	var bullet_hitbox = CollisionShape2D.new()
	
	var bullet_speed = 30000
	var bullet_lifespan_seconds = 2
	
	bullet_image.texture = load("res://projectile.webp")
	bullet_image.scale = Vector2(0.5,0.5)
	bullet.add_child(bullet_image)
	
	# give it collision
	bullet_hitbox.shape = CircleShape2D.new()
	
	bullet.set_collision_layer_value(1, false) # is not a player
	bullet.set_collision_layer_value(2, true)	
	bullet.set_collision_mask_value(1, false) # dont detect player
	
	
	bullet.add_child(bullet_hitbox)	
	
	# rotate the projectile accordingly
	bullet.rotation = direction
	add_child(bullet)
	
	# apply forces (no gravity since its top down)
	bullet.gravity_scale = 0
	bullet.apply_central_force(Vector2(cos(direction), sin(direction)) * bullet_speed)
	
	# remove the bullet after some time
	await get_tree().create_timer(bullet_lifespan_seconds).timeout
	bullet.queue_free()
	

