extends Node

var SCORE:int=0
var HIGH_SCORE:int=0

func set_score(_score:int)->void:
	SCORE+=_score
	if SCORE>HIGH_SCORE:
		HIGH_SCORE=SCORE

func get_score()->int:
	return SCORE
	
func get_high_score()->int:
	return HIGH_SCORE


func reset_score()->void:
	SCORE=0
