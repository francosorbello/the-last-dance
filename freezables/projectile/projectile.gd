extends Node2D

var speed : float = 40
var direction : Vector2:
	set(value):
		direction = value
		if value.x < 0:
			$AnimatedSprite2D.flip_h = true

func _ready():
	$FreezableComponent/FrozenVisualComponent.setup_finished.connect(_on_visual_setup)
	
func _on_area_2d_body_entered(body:Node2D) -> void:
	if $FreezableComponent.frozen: 
		return
	if body is APlayer:
		body.die()
	
	queue_free()

func _physics_process(delta):
	if $FreezableComponent.frozen:
		return
	
	position += direction * speed * delta

func _on_freezable_component_on_freeze_toggle(_is_frozen:bool) -> void:
	pass # Replace with function body.

func _on_visual_setup():
	$FreezableComponent/FrozenVisualComponent.override_param("effect_intensity",0.8)    
