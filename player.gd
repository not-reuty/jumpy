extends KinematicBody2D

var velocity = Vector2()

var speed = 1200
var max_speed = 600

var playable_width = 460

var score = 0 # raw y distance traveled
var actual_score = 0 # y distance divided by 10

onready var camera = get_node('../Camera2D')
var game_over = false
func _physics_process(delta):
	
	if game_over:
		return
		
	velocity += (Vector2.DOWN * 9.8)
	
	if Input.is_action_pressed("left"):
		velocity.x -= min(speed * delta, max_speed)
	if Input.is_action_pressed("right"):
		velocity.x += min(speed * delta, max_speed)
	velocity.x = lerp(velocity.x, 0, 0.1)
	
	if is_on_floor():
		velocity.y = -400
		print('is on floor')
		
		
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
	# screen wrapping
	var left_border = -playable_width / 2
	var right_border = playable_width / 2
	if position.x < left_border:
		position.x = right_border
	elif position.x > right_border:
		position.x = left_border
		
	# scoring
	if position.y < score:
		score = position.y
		print('new highscore: ' + str(-score / 10))
		actual_score = int(-score / 10)
		camera.position.y = position.y
	
	if -score - -position.y > 320:
		game_over = true
		game_over()
	
func game_over():
	get_node('/root/game/CanvasLayer/game_over').visible = true
	get_node('/root/game/CanvasLayer/game_over/scoretext').text = 'Score: ' + str(int(- score / 10))
