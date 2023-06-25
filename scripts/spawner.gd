extends Node

var columnsXPosfile
var columnsXPos

export var startingY = -64
export var wavespeed = 5;
var knight = preload("res://Knight.tscn")
var t = Timer.new()

var enemies = [0,knight]

#ex : [0,0,1,0,0]
# lane1:nothing lane2:noting lane3:kinght lane4:noting lane5:nothing

# 1 = kinght
# 2 = ranger

var levelOne = [[0,1,0,0,1],[1,0,0,0,0],[0,0,0,0,1],[0,0,0,1,1]]

var wave = 0
var lane = 0 

func _ready():
	columnsXPosfile = get_node("/root/global") # how to get golbal vals copy this
	columnsXPos = columnsXPosfile.columnsXPos
	t.set_wait_time(wavespeed)
	t.set_one_shot(false)
	t.connect("timeout", self, "spawnwave")
	add_child(t)
	t.start()
	# print (wave)
	# print(lane)
	# print(levelOne.size())
	# print(levelOne[wave].size())
	# while wave <= levelOne.size() -1:
	# 	print("wave: " + str(wave))
	# 	while lane <= levelOne[wave].size() -1 :
	# 		print("lane: " + str(lane))
	# 		spawn(levelOne[wave][lane], Vector2(10,0))
	# 		lane += 1
	# 	lane = 0
	# 	wave += 1

func spawnwave():
	if wave == levelOne.size():
		print("LEVEL DONE")
		return
	print("wave: " + str(wave))
	while lane <= levelOne[wave].size() -1 :
		print("lane: " + str(lane))
		spawn(levelOne[wave][lane], findpos(lane))
		lane += 1
	lane = 0
	wave += 1


func spawn(type, pos):
	if type == 0:
		return
	var k = enemies[type].instance()
	add_child(k)
	k.getColumn()
	k.position = Vector2(pos)
	print("spawning")

func findpos(i):
	return Vector2(columnsXPos[i], startingY)
