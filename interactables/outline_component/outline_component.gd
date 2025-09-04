extends Node
class_name OutlineComponent

@export var outline_shader : Shader
@export var sprite : Sprite2D

var material : ShaderMaterial
func _ready() -> void:
    material = ShaderMaterial.new()
    material.shader = outline_shader
    sprite.material = material
    disable_outline()

func enable_outline(color : Color = Color.WHITE):
    material.set_shader_parameter("width",1.0)
    material.set_shader_parameter("color",color)

func disable_outline():
    material.set_shader_parameter("width",0.0)