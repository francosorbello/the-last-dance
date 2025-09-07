@tool
extends PathFollow2D

@export var speed : float = 50
@export var initial_progress_ratio : float = 0:
    set(value):
        initial_progress_ratio = value
        if Engine.is_editor_hint() and get_parent() and get_parent() is Path2D:
            progress_ratio = initial_progress_ratio

@export var show_path : bool
@export var line_indicator_scene : PackedScene
@export var debug : bool 

var has_path : bool
var _direction_modifier : int = 1

func _ready():
    if debug:
        $FreezableComponent.debug = true
    $AnimatedSprite2D.play()
    if get_parent() is Path2D:
        has_path = true
        progress_ratio = initial_progress_ratio
        if show_path and not Engine.is_editor_hint():
            get_parent().add_child.call_deferred(line_indicator_scene.instantiate())

func _physics_process(delta):
    if Engine.is_editor_hint() or $FreezableComponent.frozen: 
        return

    if has_path:
        progress += speed * delta * _direction_modifier
        if not loop and (is_zero_approx(progress_ratio) or is_equal_approx(progress_ratio,1.0)):
            _direction_modifier *= -1
        

func _on_area_2d_body_entered(body:Node2D) -> void:
    if $FreezableComponent.frozen:
        return

    if body is APlayer:
        body.die()


func _on_frozen_visual_component_setup_finished() -> void:
    $FreezableComponent/FrozenVisualComponent.override_param("effect_intensity",0.7)
    pass # Replace with function body.


func _on_freezable_component_on_freeze_toggle(is_frozen:bool) -> void:
    if is_frozen:
        $AnimatedSprite2D.stop()
    else:
        $AnimatedSprite2D.play()
    pass # Replace with function body.
