extends Control

func _on_button_pressed() -> void:
    GlobalData.switch_to_scene("starting_scene")
    pass # Replace with function body.


func _on_salir_pressed() -> void:
    get_tree().quit()
