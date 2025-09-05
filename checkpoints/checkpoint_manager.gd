extends Node

@export var initial_checkpoint : Checkpoint

var current_checkpoint : Checkpoint

func _ready() -> void:
    current_checkpoint = initial_checkpoint
    for child in get_children():
        if child is Checkpoint:
            child.checkpoint_entered.connect(_on_checkpoint_entered)
            if child.initial:
                current_checkpoint = child

func _on_checkpoint_entered(checkpoint : Checkpoint):
    if current_checkpoint != checkpoint:
        current_checkpoint = checkpoint

func get_checkpoint_position() -> Vector2:
    if current_checkpoint:
        return current_checkpoint.checkpoint_marker.global_position
    else:
        push_error("No current checkpoint available")
        return Vector2.ZERO