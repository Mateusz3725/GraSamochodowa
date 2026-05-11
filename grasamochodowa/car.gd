extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var speed = 0.0
var can_drive = false

func _ready() -> void:
	animated_sprite_2d.play("default")

func _physics_process(delta: float) -> void:
	if can_drive == true:
		move_car()

func move_car():
	speed = speed * 0.97
	
	if Input.is_action_pressed("ui_left"):
		rotate(-0.1)
	if Input.is_action_pressed("ui_right"):
		rotate(0.1)
	
	if Input.is_action_pressed("ui_up"):
		if speed < 5:
			speed += 0.1
	if Input.is_action_pressed("ui_down"):
		if speed > -1:
			speed -= 0.1
	
	position += speed * Vector2.from_angle(rotation)
	
	move_and_slide()


func _on_hit_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("roads"):
		animated_sprite_2d.play("crash")
		can_drive = false
		await(get_tree().create_timer(1.0).timeout)
		get_tree().reload_current_scene()
