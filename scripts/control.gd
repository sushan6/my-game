extends Control

var current_level_path: String = ""

func open_control_panel() -> void:

	current_level_path = get_tree().current_scene.scene_file_path
	

	get_tree().change_scene_to_file("res://scenes/control.tscn")
	
	


func _on_resume_pressed() -> void:
	pass # Replace with function body.


func _on_main_menu_pressed() -> void:
	pass # Replace with function body.
