extends Node2D

@onready var score_label: Label = $HUD/ScorePanel/ScoreLabel



var score : int = 0

func _ready() -> void:
	_setup_level()
	
	
func _process(delta: float) -> void:
		pass
		
func _setup_level() -> void:
	
	
# connect eniemies
	var apples = $"level root".get_node_or_null("Apples")
	
	if apples:
		for enemy in apples.get_children():
			enemy.collected.connect(increase_score)
			
# connect eniemies
	var eniemies = $"level root".get_node_or_null("Eniemies")
	
	if eniemies:
		for enemy in eniemies.get_children():
			enemy.player_died.connect(_on_player_died)
			
			
			
#----------------------
# SIGNAL HANDLERS
#----------------------


func _on_player_died(body):
	body.die()
	print("Player killed")
	
	#-----------------
	#SCORE
	#-------------------
	
func increase_score() -> void:
	score += 1
	score_label.text = "SCORE: %s" % score
		
