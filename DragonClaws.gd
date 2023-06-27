extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rightclawTimer = Timer.new()
var leftclawTimer = Timer.new()
var RightClawArea
var RCposition
var LeftClawArea
var LCposition
var gobacktime = 3
var mouseposition
var claws = ['right','left']
var index = 0
var clicked = 0
# Called when the node enters the scene tree for the first time.

func _ready():
	RightClawArea = get_node("RightClaw")
	LeftClawArea = get_node("LeftClaw")
	RCposition = RightClawArea.position
	LCposition = LeftClawArea.position
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEventMouseButton && event.is_action_released("click") && clicked < 2:
		mouseposition = get_local_mouse_position()
		print("clicked at: ", mouseposition)
		moveClaw(claws[index],mouseposition)
		index = (index + 1) % 2

func moveClaw(claw,mousepos):
	clicked += 1
	if (claw == "right"):
		RightClawArea.position = mousepos
		print(RightClawArea.global_position)
		rightclawTimer.set_wait_time(gobacktime)
		rightclawTimer.set_one_shot(true)
		self.add_child(rightclawTimer)
		rightclawTimer.start()
		yield(rightclawTimer, "timeout")
		moveClawBack(claw)
	if (claw == "left"):
		LeftClawArea.position = mousepos
		print(LeftClawArea.global_position)
		leftclawTimer.set_wait_time(gobacktime)
		leftclawTimer.set_one_shot(true)
		self.add_child(leftclawTimer)
		leftclawTimer.start()
		yield(leftclawTimer, "timeout")
		moveClawBack(claw)

func moveClawBack(claw):
	if claw == 'right':
		RightClawArea.position = RCposition
	if claw == 'left':
		LeftClawArea.position = LCposition
	clicked -= 1
