extends Node

var frozen : bool = false

signal on_freeze_toggle(is_frozen : bool)

func toggle_freeze():
    frozen = !frozen
    on_freeze_toggle.emit(frozen)
