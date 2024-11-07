extends Area2D
class_name CollisionAreaEnemyTemplate

export(NodePath) onready var enemy = get_node(enemy) as KinematicBody2D

onready var timer: Timer = get_node("Timer")

export(int) var health
export(float) var invulnerability_timer

func on_collision_area_entered(area):
	if area.get_parent() is Player:
		var player_stats: Node = area.get_parent().get_node("Stats")
		var player_attack: int = player_stats.base_attack + player_stats.bonus_attack
		update_health(player_attack)
	elif area is FireSpell:
		update_health(area.spell_damage)
		set_deferred("monitoring", false)
		timer.start(invulnerability_timer)

func update_health(damage: int) -> void:
	health -= damage
	if health <= 0:
		enemy.can_die = true
		return
	enemy.can_hit = true


func on_timer_timeout():
	set_deferred("monitoring", true)
