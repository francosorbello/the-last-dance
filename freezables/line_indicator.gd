extends Line2D

func _ready():
    if get_parent() is Path2D:
        create_line(get_parent().curve.get_baked_points())
    else:
        print("parent is something else: ",get_parent())

func create_line(line_points : Array):
    points = line_points
    # queue_redraw()

func _draw():
    if points.size() >= 2:
        draw_circle(points[0],3,Color.WHITE)
        draw_circle(points[points.size()-1],3,Color.WHITE)