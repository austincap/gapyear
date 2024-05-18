extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
signal capturedImage
var points = self.get_meta("points")
var picpoints = [false, false, false]
func checkpoints():
	await get_tree().create_timer(0.1).timeout
	if false in picpoints:
		print("BAD PIC")
	else:
		emit_signal("capturedImage", self)
	picpoints = [false, false, false]

func _on_target_1_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	picpoints[0] = true
	checkpoints()


func _on_target_2_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	picpoints[1] = true
	checkpoints()


func _on_corearea_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	picpoints[2] = true
	checkpoints()
