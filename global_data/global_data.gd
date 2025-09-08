extends Node

@export var important_scenes : Dictionary[String, PackedScene]
var collectables : Array[String]

var first_play : bool = true

var bullet_pos : Vector2

func _ready():
    fade_out()

func fade_out():
    var tween := create_tween()
    tween.tween_property(%ColorRect,"color", Color(0,0,0,0),1)

func fade_in():
    var tween := create_tween()
    tween.tween_property(%ColorRect,"color", Color.BLACK,1)

func add_collectable(collectable : String):
    if not collectables.has(collectable):
        collectables.append(collectable)

func switch_to_scene(scene_name : String):
    if important_scenes.has(scene_name):
        fade_in()
        await get_tree().create_timer(1).timeout
        get_tree().change_scene_to_packed(important_scenes[scene_name])
        fade_out()
    else:
        push_error("No scene named %s"%scene_name)

func secret_ending():
    pass

func starting_cutscene():
    pass