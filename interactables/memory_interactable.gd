extends Node2D

@export var collectable_to_unlock : String
@export var sprite : Texture2D
@export var dialogue : DialogueResource
@export_group("Overrides")
@export var override_scale : bool
@export var override_scale_value : Vector2 = Vector2.ONE

func _ready():
    $FloatingSprite.texture = sprite
    if override_scale:
        $FloatingSprite.scale = override_scale_value

func _on_better_interactable_component_on_interact() -> void:
    $AudioStreamPlayer.play()
    await get_tree().create_timer(0.4).timeout
    DialogueManager.dialogue_ended.connect(_on_dialogue_end)
    DialogueManager.show_dialogue_balloon(dialogue,"start")

func _on_dialogue_end(res : DialogueResource):
    if res == dialogue:
        GlobalData.add_collectable(collectable_to_unlock)
        GlobalData.switch_to_scene("hub")