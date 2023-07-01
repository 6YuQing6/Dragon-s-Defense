extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal claw_collision

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_RightClawArea_area_entered(area):
	emit_signal("claw_collision", area)
