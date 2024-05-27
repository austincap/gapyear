extends Node2D

var dragging = false  # Are we currently dragging?
var selected = []  # Array of selected units.
var drag_start = Vector2.ZERO  # Location where drag began.
var drag_end = Vector2.ZERO
var select_rect = RectangleShape2D.new()  # Collision shape for drag box.
var selecteditem = []

func _ready():
	pass # Replace with function body.

func _process(delta):
	for item in selecteditem:
		print("selec")
		item.self_modulate = Color(1, .5, 1, 1)

func _unhandled_input(event):
	#if !(event is InputEventScreenDrag) and !(event is InputEventScreenTouch) and !(event is InputEventMouse):
	#	return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		var local_pos = get_local_mouse_position()
		var canvas_pos = get_global_transform() * local_pos
		local_pos = get_global_transform().affine_inverse() * canvas_pos
		var screen_coord = get_viewport().get_screen_transform() * get_global_transform_with_canvas() * local_pos
		#print(screen_coord)
		if event.pressed:
			# If the mouse was clicked and nothing is selected, start dragging
			if selected.size() == 0:
				dragging = true
				drag_start = get_viewport().get_screen_transform() * get_global_transform().affine_inverse() * get_global_transform() * get_local_mouse_position()
				#drag_start = event.position
		# If the mouse is released and is dragging, stop dragging
		elif dragging:
			dragging = false
			queue_redraw()
			drag_end = get_viewport().get_screen_transform() * get_global_transform().affine_inverse() * get_global_transform() * get_local_mouse_position()
			#var drag_end = event.position
			#var drag_end = get_viewport().get_mouse_position()
			select_rect.extents = abs(drag_end - drag_start) / 2
			var space = get_world_2d().direct_space_state
			var q = PhysicsShapeQueryParameters2D.new()
			q.shape = select_rect
			q.collision_mask = 2
			q.transform = Transform2D(0, (drag_end + drag_start) / 2)
			selected = space.intersect_shape(q)
			for item in selected:
				item.collider.selected = true
		if Input.is_action_just_released("click"):
			var area2d = Area2D.new()
			var collisionShape = CollisionShape2D.new()
			var collisionShapeType = RectangleShape2D.new()
			collisionShape.set_shape(collisionShapeType)
			area2d.add_child(collisionShape)
			collisionShapeType.size = (drag_end - drag_start)
			print(drag_start)
			area2d.transform = get_parent().get_global_transform()
			get_tree().get_root().add_child(area2d)
			area2d.position = ((drag_end + drag_start) / 2) * get_global_transform().affine_inverse()
			#var drag_end = event.position
			print(area2d.position)
			print("Left mouse button released.")
			$AudioStreamPlayer.play()
			#for x in area2d.get_overlapping_areas():
			#	print(x.get_name())
			
	if event is InputEventMouseMotion and dragging:
		queue_redraw()

func _draw():
	if dragging:
		draw_rect(Rect2(drag_start, get_viewport().get_screen_transform()* get_global_transform().affine_inverse() * get_global_transform() * get_local_mouse_position() - drag_start), Color.YELLOW, false, 2.0)
