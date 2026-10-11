extends Node2D

@onready var level_label: Label = $HUD/ScorePanel/HBoxContainer/LevelLabel
@onready var score_label: Label = $HUD/ScorePanel/HBoxContainer/ScoreLabel
@onready var fade: ColorRect = $HUD/Fade


var level : int = 1
var score : int = 0
var current_level_root: Node = null

func _ready() -> void:
	
	# setup the level 
	fade.modulate.a = 1.0
	current_level_root = get_node("level root")
	await _load_level(level, true, false)
	
	

#-----------------------
# level management
#-----------------------

func _load_level(level_number: int, first_load: bool, reset_score: bool) -> void:
	# fade out
	if not first_load:
		await _fade(1.0)
	
	if reset_score:
		score = 0
		score_label.text = "SCORE: 0"
	
	if current_level_root:
		current_level_root.queue_free()
		
		
	# change level
	var level_path = "res://scenes/levels/level%s.tscn" % level_number
	current_level_root = load(level_path).instantiate()
	add_child(current_level_root)
	current_level_root.name = "level root"
	_setup_level(current_level_root)
	
	# level score 
	level_label.text = "LEVEL: %s" % level_number
	
	
	
	# Fade in
	await _fade(0.0)
		
func _setup_level(level_root: Node) -> void:
# connect exits
	var exit = level_root.get_node_or_null("Exit")
	if exit:
		exit.body_entered.connect(_on_exit_body_entered)
	
# connect eniemies
	var apples = level_root.get_node_or_null("Apples")
	
	if apples:
		for enemy in apples.get_children():
			enemy.collected.connect(increase_score)
			
# connect eniemies
	var eniemies = level_root.get_node_or_null("Eniemies")
	
	if eniemies:
		for enemy in eniemies.get_children():
			enemy.player_died.connect(_on_player_died)
			
			
			
#----------------------
# SIGNAL HANDLERS
#----------------------

func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "player":
		level += 1
		print(level)
		body.can_move = false
		await _load_level (level, false, false)


func _on_player_died(body):
	body.die()
	print("Player killed")
	await _load_level (level, false, true)
	
	#-----------------
	#SCORE
	#-------------------
	
func increase_score() -> void:
	score += 1
	score_label.text = "SCORE: %s" % score
	
		
		
		
#----------------------
#FADE
#----------------------

func _fade(to_alpha: float) -> void:
	var tween := create_tween()
	tween.tween_property(fade, "modulate:a", to_alpha, 1.5)
	await tween.finished


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/control.tscn")
