extends Node
@export var waves:Array[PackedScene] = []
@export var spawnTimes:Array[float] = []

signal level_complete


"""
TODO: Properties to add. 
background for the level
background elements a layer above the background
Foreground elements 

"""


var current_idx:int = 0
var current_timer:Timer
var current_wave:Node
var level_ending = false


func _ready():
	current_idx = 0

	current_wave = null
	current_timer = $WaveSpawnTimer
	current_timer.timeout.connect(_on_wave_spawner_timeout)
	player_spawn()
	spawn_enemy_wave()


func player_spawn():
	$Player.position = $PlayerSpawn.position;
	
	



func spawn_enemy_wave():
	if level_ending: 
		return
	if current_idx >= waves.size():
		level_ending = true
		return
	print_debug("Beginning wave spawn")

	current_timer.wait_time = spawnTimes[self.current_idx]
	current_wave = waves[self.current_idx].instantiate();
	#start the enemy spawn timer of the wave
	add_child(current_wave)
	current_wave.get_child(0).start()
	current_timer.start()
	self.current_idx += 1


func _on_wave_spawner_timeout():
	spawn_enemy_wave()
	
