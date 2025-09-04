extends Node2D


func _on_interactable_component_on_hover() -> void:
    var color = Color.WHITE if $InteractableComponent.is_interactable else Color.RED
    $OutlineComponent.enable_outline(color)


func _on_interactable_component_on_leave() -> void:
    print("leave me :(")
    $OutlineComponent.disable_outline()
