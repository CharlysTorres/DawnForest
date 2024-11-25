extends Area2D
class_name ObjectTemplate

onready var animation: AnimationPlayer = get_node("Animation")

export(int) var life

func on_area_entered(area):
	if area and life > 0:
		life -= 1
		animation.play("hit")
	elif area and life <= 0:
		animation.play("breaking")

func on_animation_finished(anim_name):
	match anim_name:
		"breaking":
			queue_free()
