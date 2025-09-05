extends Node

var frozen : bool = false

signal on_freeze_toggle(is_frozen : bool)

var _frozen_visual_component : Node

func _ready():
    for child in get_children():
        if child.has_method("enable_visual"):
            _frozen_visual_component = child

func toggle_freeze():
    frozen = !frozen
    on_freeze_toggle.emit(frozen)
    if _frozen_visual_component:
        if frozen:
            _frozen_visual_component.enable_visual()
        else:
            _frozen_visual_component.disable_visual()
