extends "res://scripts/columns.gd"

var column = 1
var speed = 5
var dodgeSpeed = 50
var health = 3
var pos = self.position.x

var t = Timer.new()

func _ready():
	#print(self.position)
	self.position = Vector2(columnsXPos[column], -64)
	#print(self.position)

var no = false

func _process(delta):
	self.position.y += speed * delta
	if Input.is_mouse_button_pressed(1) && !no:
		#print("pressed")
		dodge(0, delta)

func getColumn():
	#Returns Current column INT 
	return column

func takeDmg(damage):
	#substracts health by int damage || and checks if it has died
	health -= damage

func dodge(destinationColumn, delta):
	#smoothy moves the obj to the desired coluinmb using while loops and timers def not bad code :)))
	no = true
	$Sprite.set_frame(2)
	if self.position.x <columnsXPos[destinationColumn]:
		while self.position.x < columnsXPos[destinationColumn]:
			self.position.x += 50 * delta
			t.set_wait_time(0.01)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
	if self.position.x >columnsXPos[destinationColumn]:
		while self.position.x > columnsXPos[destinationColumn]:
			self.position.x -= 50 * delta
			t.set_wait_time(0.01)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
	$AnimationPlayer.play_backwards("KnightWalk")
	t.queue_free()
	self.position = Vector2(columnsXPos[destinationColumn], self.position.y)
	$Sprite.set_frame(0)
	no = false
