extends KinematicBody2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 400
var cols = global.columnsXPos
var velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
		print(velocity.x)
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
		print(velocity.x)
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
