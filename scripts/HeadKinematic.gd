extends KinematicBody2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 100
var cols = global.columnsXPos
var maxcol = global.columnsXPos.size()
var velocity = 0
var cur_col = 2
var dest_col = cur_col
var pressed = false
var t = Timer.new()
# Called when the node enters the scene tree for the first time.
func get_input():
	velocity = 0
	if Input.is_action_pressed('ui_right'):
		velocity = 1
	if Input.is_action_pressed('ui_left'):
		velocity = -1

func change_col(destinationColumn, delta):
	pressed = true
	if (destinationColumn < maxcol && destinationColumn >= 0):
		if self.position.x < cols[destinationColumn]:
			while self.position.x < cols[destinationColumn]:
				self.position.x += speed * delta
				t.set_wait_time(0.01)
				t.set_one_shot(true)
				self.add_child(t)
				t.start()
				yield(t, "timeout")
			
		if self.position.x > cols[destinationColumn]:
			while self.position.x > cols[destinationColumn]:
				self.position.x -= speed * delta
				t.set_wait_time(0.01)
				t.set_one_shot(true)
				self.add_child(t)
				t.start()
				yield(t, "timeout")
	self.position = Vector2(cols[destinationColumn], self.position.y)
	pressed = false

func _physics_process(delta):
	get_input()
	print('velocity: ', velocity)
	if (!pressed):
		dest_col += velocity
		if (dest_col >= 0 && dest_col < maxcol):
			print('dest_col ',  dest_col)
			change_col(dest_col,delta)
			cur_col = dest_col
		else:
			dest_col = cur_col
	

func current_column():
	return cur_col
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
