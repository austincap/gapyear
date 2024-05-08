extends Node2D


# Declare member variables here. Examples:
# var a = 2
var speed = 100
var selecteditem = []
var serv

# Called when the node enters the scene tree for the first time.
func _ready():
	var CP1 = get_node("CommonPeople1")
	CP1.connect("capturedImage", captured)
	var tween = create_tween()
	tween.tween_property($Heart,"position:x", 10, 600)
	var tween2 = create_tween()
	tween2.tween_property($Bird, "position", Vector2(2000, 0), 1.0)
	#add_child($Tween)
	#tween.start()
	serv = PhysicsServer2D

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
	
func _physics_process(delta):
	pass

func captured(entity):
	print(entity.get_meta("points"))
	var GUI = get_node("GUI")
	GUI.global_position = entity.global_transform.origin
	GUI.get_node("Label").text = str("+", entity.get_meta("points"))
	await get_tree().create_timer(1.0).timeout
	GUI.get_node("Label").text = ""

func _on_area_2d_area_entered(area):
	selecteditem.append(area)
	#print("AREA ENTEREd")

func picturesnapped(area):
	if (area.is_in_group("target")):
		print("TARGET")
	if (area.is_in_group("core")):
		print("CORE")
		print(area.get_name())


func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	#	var space := serv.Physics2DDirectSpaceState
	#	var query = area.get_child(0).get_shape()
	#	#query.collide_with_areas = true
	#	#query.collide_with_bodies = false
	#	#query.set_shape($CollisionShape2D.shape)
	#	#query.transform = self.global_transform
	#	var result := space.intersect_shape(query)
	#	for area_collision in result:
	#		var areas := area_collision.collider as Area2D
	#		if is_instance_valid(area): #perhaps some other checks here
	#			print("Overlapping " + areas.name)
	print("CRAP")
	print(area.get_overlapping_areas())
	print(area.get_parent().get_name())
	print(area.get_child(0))
	if (area.is_in_group("target")):
		print("TARGET")
	if (area.is_in_group("core")):
		print("CORE")
		print(area.get_name())
	#print(local_shape_index)
	#print(area.get_meta("points"))
	#print(area.get_parent().get_name())
	#self.modulate = Color(0,1,0)
