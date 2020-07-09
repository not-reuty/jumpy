extends Node2D


const platform = preload("res://platform.tscn")

export var num_platforms = 50
var platform_separation = 120
var all_platforms = []

func _ready():
	var first_platform = platform.instance()
	first_platform.position.y = 140
	all_platforms.append(first_platform)
	add_child(first_platform)
	for x in range(num_platforms):
		print(x)
		print(all_platforms)
		var new_platform = platform.instance()
		new_platform.position.y = all_platforms[x].position.y - platform_separation
		new_platform.position.x = rand_range(-260,260)
		add_child(new_platform)
		all_platforms.append(new_platform)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
