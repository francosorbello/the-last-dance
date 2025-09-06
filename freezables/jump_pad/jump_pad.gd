extends Node2D

func _on_area_2d_body_entered(body:Node2D) -> void:
    if body.has_method("do_jump"):
        body.do_jump()
        $AudioStreamPlayer.pitch_scale = randf_range(0.7,1.3)
        $AudioStreamPlayer.play()
        $AnimationPlayer.play("bounce")
