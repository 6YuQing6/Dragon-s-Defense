extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_start_pressed():
	get_tree().change_scene("res://Main.tscn")



func _on_Credits_pressed():
	get_tree().change_scene("res://menus/credits.tscn")

func _on_controls_pressed():
	get_tree().change_scene("res://menus/controls.tscn")
	pass # Replace with function body.
