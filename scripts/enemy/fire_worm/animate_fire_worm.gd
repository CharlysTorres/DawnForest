extends EnemyAnimation
class_name FireWormAnimate

func animate(velocity: Vector2) -> void:
	if enemy.can_hit or enemy.can_die or enemy.can_attack:
		action_behavior()
	else:
		move_behavior(velocity)

func move_behavior(velocity: Vector2) -> void:
	if velocity.x != 0:
		animation.play("walk")
	else:
		animation.play("idle")

func action_behavior() -> void:
	var position_projectile: Position2D = enemy.get_node("PositionProjectile")
	var collision_hit: CollisionShape2D = enemy.get_node("EnemyAttackArea").get_node("CollisionAttack")
	var floor_ray: RayCast2D = enemy.get_node("FloorRay")
	if enemy.can_die:
		animation.play("dead")
		enemy.can_hit = false
		enemy.can_attack = false
	elif enemy.can_hit:
		animation.play("hit")
		enemy.can_attack = false
	elif enemy.can_attack and flip_h:
		animation.play("attack")
		collision_hit.position.x = -23.4
		collision_hit.position.y = -8.5
		position_projectile.position.x = -23.4
		position_projectile.position.y = -8.5
	elif enemy.can_attack and !flip_h:
		animation.play("attack")
		collision_hit.position.x = 27.5
		collision_hit.position.y = -7.8
		position_projectile.position.x = 27.5
		position_projectile.position.y = -7.8

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
