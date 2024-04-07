extends Node2D


# Declare member variables here. Examples:
# var a = 2
var speed = 100
var selecteditem = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.tween_property($Heart,"position:x", 10, 600)
	var tween2 = create_tween()
	tween2.tween_property($Bird, "position", Vector2(2000, 0), 1.0)
	#add_child($Tween)
	#tween.start()


func _on_Tween_tween_completed(_object, _key):
	var tween = create_tween()
	if $Heart.position.x > 500: 
		tween.tween_property($Heart,"position:x", 10, 600)
	else:
		tween.tween_property($Heart,"position:x", 600, 10)

	#tween.start()


func _process(delta):
	$Path2D/PathFollow2D.loop = true
	$Path2D/PathFollow2D.progress+= speed*delta


func _on_area_2d_area_entered(area):
	selecteditem.append(area)
	print("AREA ENTEREd")
