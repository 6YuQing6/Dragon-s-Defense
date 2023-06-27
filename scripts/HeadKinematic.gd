extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 100
export var health = 100
var cols = global.columnsXPos
var maxcol = global.columnsXPos.size()
var velocity = 0
var cur_col = 2
var dest_col = cur_col
var pressed = false
var t = Timer.new()
var Animator
var healthbar

export var fireDmg = 3


func _ready():
	Animator = get_node("AnimationPlayer")
	healthbar = get_node("/root/Node2D/HealthBar/TextureProgress")
	if healthbar == null:
		print('Null healthbar')
	healthbar.max_value = health
	healthbar.value = health
	print(healthbar.max_value)
	print(healthbar.value)

# Called when the node enters the scene tree for the first time.
func get_input():
	velocity = 0
	if (Animator.current_animation != "Fire" && Animator.current_animation == "Idle"):
		if Input.is_action_pressed('ui_right'):
			velocity = 1
		if Input.is_action_pressed('ui_left'):
			velocity = -1
	if (!Input.is_action_pressed('ui_left') && !Input.is_action_pressed('ui_right') && Animator.current_animation == "Idle" && Input.is_action_pressed('ui_select')):
		fireAtk()
	if (!Input.is_action_pressed('ui_left') && !Input.is_action_pressed('ui_right') && Animator.current_animation == "Idle" && Input.is_action_pressed('ui_up')):
		biteAtk()

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
	#print('velocity: ', velocity)
	if (!pressed):
		dest_col += velocity
		if (dest_col >= 0 && dest_col < maxcol):
			#print('dest_col ',  dest_col)
			change_col(dest_col,delta)
			cur_col = dest_col
		else:
			dest_col = cur_col
	
func fireAtk():
	global.columnsAttack[current_column()] = 1 #how to do atk!!!!
	#print(global.columnsAttack)
	Animator.play("Fire")
	yield(Animator,"animation_finished")
	global.columnsAttack[current_column()] = 0 #how to do atk!!!!
	#print(global.columnsAttack)
	idleState()
	#FireColumn.visible = true
	#t.set_wait_time(seconds)
	#t.set_one_shot(true)
	#self.add_child(t)
	#t.start()
	#FireColumn.visible = false


var ikinght = 0
func fireAtkDmg(dmg):
	print(global.columnsAttackDmg)
	if global.listofKinghts.size() == 0:
		return
	while ikinght < global.listofKinghts.size():
		print(current_column())
		print(global.listofKinghts[ikinght].column)
		if global.listofKinghts[ikinght].column == current_column():
			global.listofKinghts[ikinght].takeDmg(dmg)
		ikinght += 1
	ikinght = 0
	yield(Animator,"animation_finished")
	print(global.columnsAttackDmg)


func biteAtk():
	Animator.play("Bite")
	global.columnsAttack[current_column()] = 1
	yield(Animator,"animation_finished")
	global.columnsAttack[current_column()] = 0
	idleState()

func idleState():
	Animator.play("Idle")

func takeDmg(amounttaken):
	#print(amounttaken)
	if (health > 0):
		health -= amounttaken
		#print('health')
	else:
		die()
	healthbar.value = health

func die():
	pass
	#print("dragon ded")


func current_column():
	return cur_col

