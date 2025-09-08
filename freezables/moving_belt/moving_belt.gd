@tool
extends Path2D

@export_tool_button("Create", "Callable") var create_belt_action = create_belt
@export var width : float = 30
@export var move_speed : float = 30

var attached_entity : Node2D
var prev_attached_entity : Node2D

var moving_entity : bool = false

var direction : Vector2

func _ready():
	create_belt()

func create_belt():
	if curve.get_baked_points().is_empty():
		clear_belt()
		return

	var start_point = curve.get_baked_points()[0]
	var end_point = curve.get_baked_points()[curve.get_baked_points().size()-1]

	direction = (end_point - start_point).normalized().round()

	var p1 = Vector2(start_point.x,start_point.y + width/2)
	var p2 = Vector2(end_point.x  , start_point.y + width/2)
	var p3 = Vector2(end_point.x  , end_point.y - width/2)
	var p4 = Vector2(start_point.x, start_point.y - width/2)
	
	var polygon : PackedVector2Array = []
	
	polygon.append(p1)
	polygon.append(p2)
	polygon.append(p3)
	polygon.append(p4)
	
	$Area2D/Polygon2D.polygon = polygon
	$Area2D/CollisionPolygon2D.polygon = polygon
	$Line2D.points = polygon
	if Engine.is_editor_hint():
		return
	$FreezableComponent/FrozenVisualComponent.setup_finished.connect(_setup_shader_direction)

func _setup_shader_direction():
	# wait for visual component to be ready (ie: duplicate the material if needed)
	
	var dir = sign(direction.x) * 1
	$FreezableComponent/FrozenVisualComponent.override_param("speedx",dir)
	# $FreezableComponent/FrozenVisualComponent.override_param("fbm_speed",dir*2)

func _physics_process(delta):
	if moving_entity:
		$AnchorPoint.progress += move_speed * delta
		if is_equal_approx($AnchorPoint.progress_ratio,1.0):
			$DisabledTimer.start()
			detach()


func clear_belt():
	$Area2D/Polygon2D.polygon = []
	$Area2D/CollisionPolygon2D.polygon = []
	$Line2D.points = []

func attach(entity : Node2D):
	if moving_entity or entity.get_parent() == $AnchorPoint: 
		return
	
	attached_entity = entity
	
	# entity.get_parent().remove_child(entity)
	
	var distance = abs(entity.global_position.x - $AnchorPoint.global_position.x)
	$AnchorPoint.progress += distance 

	# $AnchorPoint.add_child(entity)
	entity.position = Vector2.ZERO
	
	moving_entity = true
	
func detach(force_detachment : bool = false):
	$DisabledTimer.start()
	if attached_entity:
		# $AnchorPoint.remove_child(attached_entity)

		# prev_attached_parent.add_child(attached_entity)
		# attached_entity.global_position = $AnchorPoint.global_position
		attached_entity.detach_from_belt($AnchorPoint.progress_ratio > 0.9 and not force_detachment)

		moving_entity = false

	$AnchorPoint.progress_ratio = 0

	prev_attached_entity = attached_entity
	attached_entity = null

func _on_area_2d_body_entered(body:Node2D) -> void:
	if $DisabledTimer.time_left > 0:
		return

	if body == attached_entity:
		return

	if $FreezableComponent.frozen:
		return
	# if prev_attached_entity and body == prev_attached_entity:
	#     return

	if body.has_method("can_be_attached") and body.can_be_attached():
		attach.call_deferred(body)
		body.attach_to_belt.call_deferred($AnchorPoint, self)
	# 	attach(body)


func _on_freezable_component_on_freeze_toggle(is_frozen: bool) -> void:
	if is_frozen and attached_entity != null:
		detach()


func _on_freezable_component_on_restart() -> void:
	$DisabledTimer.stop()
	pass # Replace with function body.
