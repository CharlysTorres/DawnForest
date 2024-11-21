extends EnemyAnimation
class_name SkeletonSeekerAnimation

func animate(velocity: Vector2) -> void:
	if enemy.can_hit or enemy.can_die or enemy.can_attack:
		action_behavior()
	else:
		move_behavior(velocity)

func move_behavior(velocity: Vector2) -> void:
	if enemy.has_spawn:
		if enemy.enemy_spawned:
			if velocity.x != 0:
				animation.play("walk")
			else:
				animation.play("idle")

func action_behavior() -> void:
	var collision_hit: CollisionShape2D = enemy.get_node("EnemyAttackArea").get_node("Collision")
	if enemy.can_die:
		animation.play("dead")
		enemy.can_hit = false
		enemy.can_attack = false
	elif enemy.can_hit:
		animation.play("hit")
		enemy.can_attack = false
	elif enemy.can_attack and flip_h:
		animation.play("attack")
		collision_hit.position.x *= -1
	elif enemy.can_attack and !flip_h:
		animation.play("attack")
		collision_hit.position.x = 22.459

func on_animation_finished(anim_name: String):
	match anim_name:
		"hit":
			enemy.can_hit = false
			enemy.set_physics_process(true)
		"dead":
			enemy.kill_enemy()
		"kill":
			enemy.queue_free()
		"attack":
			enemy.can_attack = false
		"spawn":
			enemy.enemy_spawned = true
