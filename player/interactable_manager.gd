extends Node

var current_interactable : InteractableComponent

func _on_interactable_detector_interactable_found(interactable:InteractableComponent) -> void:
    if current_interactable:
        current_interactable.leave_interactable()
    current_interactable = interactable
    current_interactable.hover_interactable()

func use_interactable():
    if not current_interactable:
        return
    current_interactable.interact()
    current_interactable = null

func _on_interactable_detector_interactable_lost(interactable:InteractableComponent) -> void:
    if current_interactable == interactable:
        current_interactable.leave_interactable()
        current_interactable = null
