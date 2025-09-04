extends Area2D

signal damage_taken

func _on_body_entered(body:Node2D) -> void:
    if body is TileMapLayer:
        damage_taken.emit()
