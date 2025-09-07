extends Node2D

var _frozen_component : Node

func _ready() -> void:
    for child in get_children():
        if child.has_method("toggle_freeze"):
            _frozen_component = child
        pass

func _on_area_2d_body_entered(body:Node2D) -> void:
    if _frozen_component and _frozen_component.frozen:
        return

    if body.has_method("do_jump"):
        body.do_jump()
        $AudioStreamPlayer.pitch_scale = randf_range(0.7,1.3)
        $AudioStreamPlayer.play()
        $AnimationPlayer.play("bounce")
