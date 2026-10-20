extends Node

var current_level_path: String = ""


func change_level(target_scene_path: String) -> void:
	current_level_path = target_scene_path
	get_tree().change_scene_to_file(target_scene_path)
