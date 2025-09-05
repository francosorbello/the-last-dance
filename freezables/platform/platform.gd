@tool
extends PathFollow2D

@export var speed : float = 50
@export var initial_progress_ratio : float = 0:
    set(value):
        initial_progress_ratio = value
        if Engine.is_editor_hint() and get_parent() and get_parent() is Path2D:
            progress_ratio = initial_progress_ratio


var has_path : bool
var _direction_modifier : int = 1

func _ready():
    if get_parent() is Path2D:
        has_path = true
        progress_ratio = initial_progress_ratio

func _physics_process(delta):
    if Engine.is_editor_hint() or $FreezableComponent.frozen: 
        return

    if has_path:
        progress += speed * delta * _direction_modifier
        if not loop and is_zero_approx(progress_ratio) or is_equal_approx(progress_ratio,1.0):
            _direction_modifier *= -1
        
func _on_freezable_component_on_freeze_toggle(_is_frozen:bool) -> void:
    pass # Replace with function body.
