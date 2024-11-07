extends Area2D
class_name ProjectileWorm

onready var sprite: Sprite = get_node("Sprite")
onready var animation: AnimationPlayer = get_node("Animation")

export(int) var speed = 70
var direction: int = 1
export(int) var damage = 15
export(float) var invencibility_timer = 1.0

func _process(delta) -> void:
	position.x += speed * direction * delta

func set_direction(dir) -> void:
	direction = dir
	if dir < 0:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false

func on_animation_finished(anim_name):
	match anim_name:
		"explosion":
			queue_free()
