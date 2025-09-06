extends Node2D

var speed : float = 40
var direction : Vector2

func _on_area_2d_body_entered(body:Node2D) -> void:
    if $FreezableComponent.frozen: 
        return
    if body is APlayer:
        body.die()

func _physics_process(delta):
    if $FreezableComponent.frozen:
        return
    
    position += direction * speed * delta

func _on_freezable_component_on_freeze_toggle(is_frozen:bool) -> void:
    pass # Replace with function body.
