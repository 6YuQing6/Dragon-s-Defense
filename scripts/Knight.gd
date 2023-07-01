extends KinematicBody2D

var columnsXPosfile
var columnsXPos

var rng = RandomNumberGenerator.new()

var idenifyer = -1
var column = 0 #starting column
export var speed = 5 #speed it walks down
export var attack = 10 #how much attack it has
var dodgeSpeed = 25 #how fast it dodges
var health = 3 #number of hits it can take
var pos = self.position.x #starting pos
var dodgeDelay = 10
var takingDmg = false
var inDamageProcess = false

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
	if self.position.y >= 32 && !ded:
		#print("ATTTTACKKKKKK")
		atk()
		#maybe call dragon take dmg func????? MKAE IT SUNYNN!
	if !ded:
		predict()
	# if !takingDmg:
	# 	seeDmg()
	# 	if takingDmg == true:
	# 		inDamageProcess = true
	# 		takingDmg = false
	


func getColumn():
	#Returns Current column INT 
	return column

func takeDmg(damage):
	var bspeed = speed
	#print("sped", speed)
	if inDamageProcess:
		return
	inDamageProcess = true
	speed = 0
	Sprites.set_frame(5)
	#subtracts health by int damage || and checks if it has died
	t.set_wait_time(0.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	health -= damage
	print("health: " + str(health))
	if health <= 0:
		print("ded")
		die()
	else:
		speed = bspeed
		Animator.play("KnightAttack")
		inDamageProcess = false
		#print("sped", speed)

var ded = false
func die():
	ded = true
	global.listofKinghts.remove(global.listofKinghts.find(self))
	Animator.play("die")


func atk():
	speed = 0
	Animator.play("atk")

func doDmg():
	#print('doing dmg: ', attack)
	Dragon.takeDmg(attack)

func predict():
	if columnsXPosfile.columnsAttack[column] > 0:
		if column == 0:
			dodge(column + 1)
		elif column == 4:
			dodge(column - 1)
		else:
			if rng.randi_range(0,1) == 1:
				dodge(column + 1)
			else:
				dodge(column - 1)
	pass

func seeDmg():
	#print("b: ", takingDmg)
	if takingDmg:
		return
	takingDmg = true
	if columnsXPosfile.columnsAttackDmg[column] > 0:
		print("owing")
		print(takingDmg)
		takeDmg(1)
		return

func returnID():
	return idenifyer

var dodging = false
func dodge(destinationColumn):
	#print("doding ")
	if dodging == true:
		return
	dodging = true
	if destinationColumn == column:
		return
	#smoothy moves the obj to the desired coluinmb using while loops and timers def not bad code :)))
	no = true
	Animator.stop()
	#checks the direction shuold the kinght dodge
	if self.position.x <columnsXPos[destinationColumn]:
		Sprites.set_frame(3)
		#solwy moves the spirte to the dest column
		while self.position.x < columnsXPos[destinationColumn]:
			self.position.x += dodgeSpeed * get_process_delta_time()
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
			self.position.x -= dodgeSpeed * get_process_delta_time()
			t.set_wait_time(0.01)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
	#Failsafe to just teleport the kinght to the correct pos
	column = destinationColumn
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

	print("waiting")
	t.set_wait_time(dodgeDelay)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	print("done")

	dodging = false



func _on_Area2D_area_entered(area:Area2D):
	pass # Replace with function body.

