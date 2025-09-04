extends Area2D

signal interactable_found(interactable : InteractableComponent)
signal interactable_lost(interactable : InteractableComponent)
func _on_area_entered(area:Area2D) -> void:
    if area is InteractableComponent:
        interactable_found.emit(area)
        pass

func _on_area_exited(area:Area2D) -> void:
    if area is InteractableComponent:
        interactable_lost.emit(area)
    pass # Replace with function body.
