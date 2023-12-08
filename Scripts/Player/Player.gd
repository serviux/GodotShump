extends Node2D
@export var speed: int = 400
@export var bullet: PackedScene
@export var rof: float = 0.2
var is_firing = false
var screen_max: Vector2

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_max = get_viewport_rect().size
	$PlayerROF.wait_time = rof



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move(delta)
	if(Input.is_action_pressed("shoot")):
		fire(is_firing)
	
	

func move(delta):
	var velocity = Vector2.ZERO
	if(Input.is_action_pressed("move_down")):
		velocity.y = 1
	if(Input.is_action_pressed("move_up")):
		velocity.y = -1
	if(Input.is_action_pressed("move_left")):
		velocity.x = -1
	if(Input.is_action_pressed("move_right")):
		velocity.x = 1
	
	if(velocity.length() > 0):
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_max)


func fire(firing:bool):
	if(firing):
		return
	var bullet_scene = bullet.instantiate()
	#add the player position, so the bullet spawns in front of where the player currently is
	var spawn_pos = $BulletSpawn.position + position
	bullet_scene.position = spawn_pos
	add_sibling(bullet_scene)
	is_firing = true
	$PlayerROF.start()


func _on_player_rof_timeout():
	is_firing = false
	
