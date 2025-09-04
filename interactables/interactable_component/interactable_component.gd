extends Area2D
class_name InteractableComponent

@export var is_interactable : bool = true

signal on_interact
signal on_hover
signal on_leave

var outline_component

func _ready() -> void:
    for child in get_children():
        if child.has_method("enable_outline"):
            outline_component = child

func interact():
    if is_interactable:
        on_interact.emit()

func hover_interactable():
    on_hover.emit()
    if outline_component:
        outline_component.enable_outline(Color.WHITE if is_interactable else Color.RED)

func leave_interactable():
    on_leave.emit()
    if outline_component:
        outline_component.disable_outline()