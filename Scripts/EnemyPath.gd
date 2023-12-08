extends Path2D

@export var enemies:Array[PackedScene] = []
var total_enemies = 0
var current_idx = 0
var total_enemies_killed = 0
signal all_enemies_dead

# Called when the node enters the scene tree for the first time.
func _ready():
	total_enemies = enemies.size()
	total_enemies_killed = 0
	current_idx = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_spawn_timer_timeout():
	spawn() 


func spawn():
	if(current_idx >= total_enemies):
		return
	var mob = enemies[current_idx].instantiate()
	mob.enemy_path = self
	mob.on_spawn()
	add_child(mob)
	current_idx += 1
	mob.death.connect(_on_enemy_death)
	

func _on_enemy_death():
	total_enemies_killed += 1
	
	
	
