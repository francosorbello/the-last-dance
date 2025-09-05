@tool
extends Area2D
class_name Checkpoint

@export var initial : bool = false:
	set(value):
		if value:
			_set_as_initial()
		initial = value

var checkpoint_marker : Marker2D

signal checkpoint_entered(checkpoint : Checkpoint)

func _set_as_initial():
	if not Engine.is_editor_hint():
		return
	for child in get_parent().get_children():
		if child is Checkpoint:
			child.initial = false

func _ready() -> void:
	for child in get_children():
		if child is Marker2D:
			checkpoint_marker = child
			return

func _get_configuration_warnings() -> PackedStringArray:
	for child in get_children():
		if child is Marker2D:
			return []
	return ["Marker2D is missing"]


func _on_body_entered(body:Node2D) -> void:
	if body is APlayer:
		checkpoint_entered.emit(self)
