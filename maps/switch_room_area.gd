extends Area2D
class_name SwitchRoomArea

@export var switch_to : String

signal on_switch_to(room : String)

func _on_body_entered(body:Node2D) -> void:
    if body is APlayer:
        on_switch_to.emit(switch_to)
