extends "res://scripts/columns.gd"

var column = 0
var speed = 1
var dodgeSpeed = 0.01
var health = 3
var pos = self.position.x


func _ready():
	print(self.position)
	self.position = Vector2(columnsXPos[column], -64)
	print(self.position)

var no = false

func _process(delta):
	self.position.y += speed * delta
	if Input.is_mouse_button_pressed(1) && !no:
		print("pressed")
		dodge(3)

func getColumn():
	#Returns Current column INT 
	return column

func takeDmg(damage):
	#substracts health by int damage || and checks if it has died
	health -= damage

func dodge(destinationColumn):
	no = true
	if self.position.x <columnsXPos[destinationColumn]:
		while self.position.x < columnsXPos[destinationColumn]:
			self.position.x += 0.5 * get_process_delta_time()
			print(self.position.x)
	elif self.position.x > columnsXPos[destinationColumn]:
		while self.position.x < columnsXPos[destinationColumn]:
			self.position.x -= dodgeSpeed * get_process_delta_time()
	#self.position = Vector2(columnsXPos[destinationColumn], self.position.y)
	no = false
