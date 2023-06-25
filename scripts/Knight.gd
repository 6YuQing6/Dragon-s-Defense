extends KinematicBody2D

var columnsXPosfile
var columnsXPos

var column = 0 #starting column
export var speed = 5 #speed it walks down
var dodgeSpeed = 25 #how fast it dodges
var health = 3 #number of hits it can take
var pos = self.position.x #starting pos

#child nodes
var Animator
var Sprites
var Dragon

#timer for various things
var t = Timer.new()

func _ready():
	columnsXPosfile = get_node("/root/global") # how to get golbal vals copy this
	columnsXPos = columnsXPosfile.columnsXPos
	Dragon = get_node("/root/Node2D/DragonHead")
	Animator = get_node("AnimationPlayer")
	Sprites = get_node("Sprite")
	#print(self.position)
	self.position = Vector2(columnsXPos[column], -64) # teleports to the top and the starting column
	#print(self.position)

var no = false

func _process(delta):
	self.position.y += speed * delta
	if Input.is_mouse_button_pressed(1) && !no:
		#print("pressed")
		#dodge(1, delta)
		takeDmg(3)
	if self.position.y >= 32 && !ded:
		#print("ATTTTACKKKKKK")
		atk()
		#maybe call dragon take dmg func????? MKAE IT SUNYNN!
	


func getColumn():
	#Returns Current column INT 
	return column

func takeDmg(damage):
	#print(health)
	speed = 0
	Sprites.set_frame(5)
	#substracts health by int damage || and checks if it has died
	t.set_wait_time(0.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")

	health -= damage
	if health <= 0:
		print("ded")
		die()
		return
	speed = 5
	Animator.play("KnightAttack")

var ded = false
func die():
	ded = true
	Animator.play("die")


func atk():
	speed = 0
	Animator.play("atk")

func doDmg():
	Dragon.takeDmg(1)
	pass
		
func predict():
	#MAKE THE ATTACKS SO I CAN DO THIS
	pass

func dodge(destinationColumn, delta):
	#smoothy moves the obj to the desired coluinmb using while loops and timers def not bad code :)))
	no = true
	Animator.stop()
	#checks the direction shuold the kinght dodge
	if self.position.x <columnsXPos[destinationColumn]:
		Sprites.set_frame(3)
		#solwy moves the spirte to the dest column
		while self.position.x < columnsXPos[destinationColumn]:
			self.position.x += dodgeSpeed * delta
			#BAD CODE PLZ DO NOT COPY it pauses so that the sprite is rendered
			t.set_wait_time(0.01)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
	#reapeat of the above code 
	if self.position.x >columnsXPos[destinationColumn]:
		Sprites.set_frame(3)
		Sprites.set_flip_h(true)
		while self.position.x > columnsXPos[destinationColumn]:
			self.position.x -= dodgeSpeed * delta
			t.set_wait_time(0.01)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
	#Failsafe to just teleport the kinght to the correct pos
	self.position = Vector2(columnsXPos[destinationColumn], self.position.y)

	#animation for rolling
	Sprites.set_frame(4)

	t.set_wait_time(0.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")

	Sprites.set_frame(0)
	Sprites.set_flip_h(false)

	#return to normal walk animation
	Animator.play("KnightAttack")
	no = false
