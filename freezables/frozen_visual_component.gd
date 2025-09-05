extends Node

@export var material : ShaderMaterial
@export var sprite : Sprite2D

var _material_instance : ShaderMaterial

func _ready() -> void:
    await get_tree().process_frame
    _material_instance = material.duplicate()
    sprite.material = _material_instance
    disable_visual()

func enable_visual():
    _material_instance.set_shader_parameter("enabled",true)

func disable_visual():
    _material_instance.set_shader_parameter("enabled",false)
