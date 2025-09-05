extends Node

@export var material : ShaderMaterial
@export var visual : CanvasItem

var _material_instance : ShaderMaterial

func _ready() -> void:
    await get_tree().process_frame
    if visual.material == null:
        _material_instance = material.duplicate()
        visual.material = _material_instance
    else:
        _material_instance = visual.material
    
    disable_visual()

func enable_visual():
    _material_instance.set_shader_parameter("enabled",true)

func disable_visual():
    _material_instance.set_shader_parameter("enabled",false)
