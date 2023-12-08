extends Node2D

@export var speed = 400
@export var collision_group_name: String


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move(delta)
	
	

func move(delta):
	var vel = Vector2.ZERO
	var speed_normal = speed * delta
	vel.x = speed_normal
	position += vel;
	


func _on_time_alive_timeout():
	queue_free()



func _on_hitbox_body_entered(body):
	if(body.is_in_group(collision_group_name)):
		queue_free()

