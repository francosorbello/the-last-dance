extends Node2D

@export var dialogue : DialogueResource

func _ready():
    await get_tree().create_timer(1).timeout
    DialogueManager.show_dialogue_balloon(dialogue,"start")
