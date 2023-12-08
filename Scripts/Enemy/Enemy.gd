extends PathFollow2D

@export var player_bullet_group: String
@export var speed: float 
@export var health: int
@export var enemy_path: Path2D
@export var score_when_killed: int

signal death(points)
signal despawn
# Called when the node enters the scene tree for the first time.
func on_spawn():
	progress = 0
	progress_ratio = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(health <= 0):
		death.emit(score_when_killed)
		queue_free() 
	var progress_amount = 0
	progress_amount += speed * delta
	progress += progress_amount
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	despawn.emit()
	queue_free() # Replace with function body.

