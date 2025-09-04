@tool
extends Path2D

@export_tool_button("Create", "Callable") var create_belt_action = create_belt
@export var width : float = 30

func create_belt():

    if curve.get_baked_points().is_empty():
        clear_belt()
        return

    var start_point = curve.get_baked_points()[0]
    var end_point = curve.get_baked_points()[curve.get_baked_points().size()-1]
    print(curve.get_baked_points())

    var p1 = Vector2(start_point.x,start_point.y + width/2)
    var p2 = Vector2(end_point.x  , start_point.y + width/2)
    var p3 = Vector2(end_point.x  , end_point.y - width/2)
    var p4 = Vector2(start_point.x, start_point.y - width/2)
    
    var polygon : PackedVector2Array = []
    
    polygon.append(p1)
    polygon.append(p2)
    polygon.append(p3)
    polygon.append(p4)
    
    $StaticBody2D/Polygon2D.polygon = polygon
    $StaticBody2D/CollisionPolygon2D.polygon = polygon

func clear_belt():
    $StaticBody2D/Polygon2D.polygon = []
    $StaticBody2D/CollisionPolygon2D.polygon = []