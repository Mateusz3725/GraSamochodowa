extends Node2D

@onready var start_timer: Timer = $StartTimer
@onready var start_321: Label = $StartTimer/Start321
@onready var car: CharacterBody2D = $Car

var checkpoints = [false, false, false]

func _ready() -> void:
	pass 



func _process(delta: float) -> void:
	if start_timer.time_left > 1:
		start_321.text = str(floor(start_timer.time_left))
	elif start_timer.time_left > 0:
		start_321.text = "START!"
	else:
		start_321.text = ""


func _on_start_end_area_entered(area: Area2D) -> void:
	if area.name == "HitArea" and checkpoints == [true, true, true]:
		await(get_tree().create_timer(0.5).timeout)
		car.can_drive = false
		get_tree().reload_current_scene()


func _on_start_timer_timeout() -> void:
	car.can_drive = true


func _on_checkpoint_1_area_entered(area: Area2D) -> void:
	if area.name == "HitArea":
		checkpoints[0] = true


func _on_checkpoint_2_area_entered(area: Area2D) -> void:
	if area.name == "HitArea":
		checkpoints[1] = true


func _on_checkpoint_3_area_entered(area: Area2D) -> void:
	if area.name == "HitArea":
		checkpoints[2] = true
