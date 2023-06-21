extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var decrease_health_timer = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area is Knight:
		start_decreasing_health(area.attack_damage)

func start_decreasing_heatlh(attack_damage):
	decrease_health_timer = Timer.new()
	decrease_health_timer.connect("timeout",self,"_decrease_health",[attack_damage])
	decrease_health_timer.start()

func _decrease_health(attack_damage):
	health -= attack_damage


