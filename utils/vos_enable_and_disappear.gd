extends VisibleOnScreenEnabler2D
# enables a thing that enters the screen and deletes itself

func _on_screen_entered() -> void:
    queue_free()
    pass # Replace with function body.
