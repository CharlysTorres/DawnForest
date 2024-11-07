extends EnemyAnimation
class_name SkeletonAnimation

func animate(velocity: Vector2) -> void:
	if enemy.can_hit or enemy.can_die or enemy.can_attack:
		action_behavior()
	else:
		move_behavior(velocity)

func move_behavior(velocity: Vector2) -> void:
	var collision: CollisionShape2D = enemy.get_node("Collision")
	var collisionHit: CollisionShape2D = enemy.get_node("CollisionArea").get_node("Collision")
	var floor_ray: RayCast2D = enemy.get_node("FloorRay")
	if velocity.x != 0:
		animation.play("walk")
		if velocity.x < 0:
			# Changing collision and floor_ray position in code when enemy changes position while moving
			collision.position.x = 5.279
			collision.position.y = 3.581
			floor_ray.position.x = -4.573
			collisionHit.position.x = 5.279
			collisionHit.position.y = 3.581
		elif velocity.x > 0:
			# Changing collision and floor_ray position in code when enemy changes position while moving
			collision.position.x = -3.5
			collision.position.y = 4
			floor_ray.position.x = 6.5
			collisionHit.position.x = -3.5
			collisionHit.position.y = 4
	else:
		animation.play("idle")
		if flip_h:
			# Changing collision and floor_ray position in code when enemy changes position when stationary
			collision.position.x = -4.9
			collision.position.y = 4
			floor_ray.position.x = 4
			collisionHit.position.x = -4.9
			collisionHit.position.y = 4
		else:
			# Changing collision and floor_ray position in code when enemy changes position when stationary
			collision.position.x = 5.279
			collision.position.y = 3.581
			floor_ray.position.x = -4.573
			collisionHit.position.x = 5.279
			collisionHit.position.y = 3.581

func action_behavior() -> void:
	var collision: CollisionShape2D = enemy.get_node("Collision")
	var collisionHit: CollisionShape2D = enemy.get_node("CollisionArea").get_node("Collision")
	var floor_ray: RayCast2D = enemy.get_node("FloorRay")
	if enemy.can_die:
		animation.play("dead")
		enemy.can_hit = false
		enemy.can_attack = false
	elif enemy.can_hit:
		animation.play("hit")
		enemy.can_attack = false
	elif enemy.can_attack and !flip_h:
		animation.play("attack_left")
		collision.position.x = 5.279
		collision.position.y = 3.581
		floor_ray.position.x = -4.573
		collisionHit.position.x = 5.279
		collisionHit.position.y = 3.581
	elif enemy.can_attack and flip_h:
		animation.play("attack_right")
		collision.position.x = -3.5
		collision.position.y = 4
		floor_ray.position.x = 6.5
		collisionHit.position.x = -3.5
		collisionHit.position.y = 4

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
