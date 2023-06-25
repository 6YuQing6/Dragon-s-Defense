extends Node

var wavespeed = 1;

#ex : [0,0,1,0,0]
# lane1:nothing lane2:noting lane3:kinght lane4:noting lane5:nothing

# 1 = kinght
# 2 = ranger

var levelOne = [[0,1,0,0,1],[1,0,0,0,0],[0,0,0,0,1],[0,0,0,1,1]]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
var wave = 0
var lane = 0 
func _ready():
	while wave < levelOne.size():
		print("spawning wave")
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
