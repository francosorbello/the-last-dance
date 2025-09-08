extends Node

@export var dialogue: DialogueResource

func _ready() -> void:
    $CanvasLayer/Control/TextureRect.visible = false
    $AudioStreamPlayer.play()
    await $AudioStreamPlayer.finished
    $AudioStreamPlayer2.play()
    DialogueManager.show_dialogue_balloon(dialogue, "start")
    DialogueManager.dialogue_ended.connect(_on_dialogue_end)

func show_drawing():
    $CanvasLayer/Control/TextureRect.visible = true

func _on_dialogue_end(_res):
    if _res == dialogue:
        GlobalData.switch_to_scene("menu")