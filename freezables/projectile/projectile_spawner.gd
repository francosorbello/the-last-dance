@tool
extends Node2D

@export var projectile_scene : PackedScene
@export var direction : Vector2:
    set(value):
        direction = value
        if Engine.is_editor_hint():
            queue_redraw()
@export var spawn_interval : float = 2
@export var override_speed : bool = false
@export var override_speed_value : float = 100

func _ready():
    if Engine.is_editor_hint():
        return
    $SpawnIntervalTimer.start(spawn_interval)


func _on_spawn_interval_timer_timeout() -> void:
    spawn_projectile()
    pass # Replace with function body.

func spawn_projectile():
    var new_projectile = projectile_scene.instantiate()
    add_child(new_projectile)
    new_projectile.direction = direction
    if override_speed:
        new_projectile.speed = override_speed_value

func _on_freezable_component_on_freeze_toggle(is_frozen:bool) -> void:
    if is_frozen:
        $SpawnIntervalTimer.stop()
    else:
        $SpawnIntervalTimer.start(spawn_interval)

func _draw() -> void:
    if Engine.is_editor_hint():
        draw_line(Vector2.ZERO, direction * 10,Color.WHITE,2)