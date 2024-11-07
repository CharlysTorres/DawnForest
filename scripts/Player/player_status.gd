extends Node
class_name PlayerStats

export(PackedScene) var floating_text
export(NodePath) onready var player = get_node(player) as KinematicBody2D
export(NodePath) onready var collision_area = get_node(collision_area) as Area2D
onready var invicibility_timer: Timer = get_node("InvencibilityTimer")

var shielding: bool = false

var base_health: int = 15
var base_mana: int = 10
var base_attack: int = 1
var base_magic_attack: int = 3
var base_defense: int = 1

var bonus_health: int = 0
var bonus_mana: int = 0
var bonus_attack: int = 0
var bonus_magic_attack: int = 0
var bonus_defense: int = 0

var current_mana: int
var current_health: int

var max_mana: int
var max_health: int

var current_exp: int = 0

var level: int = 1

func _ready() -> void:
	current_mana = base_mana + bonus_mana
	max_mana = current_mana
	
	current_health = base_health + bonus_health
	max_health = current_health
	
	get_tree().call_group("bar_container", "init_bar", max_health, max_mana, experience_to_next_level(level))

func experience_to_next_level(currentLevel: int) -> int:
	var next_experience = pow((currentLevel + 1) * 4, 2)
	return next_experience

func update_exp(value: int) -> void:
	current_exp += value
	spawn_floating_text("+", "Exp", value)
	get_tree().call_group("bar_container", "update_bar", "ExpBar", current_exp)
	if current_exp >= experience_to_next_level(level):
		var leftover: int = current_exp - experience_to_next_level(level)
		current_exp = leftover
		level += 1
		on_level_up()
	elif current_exp >= experience_to_next_level(level):
		current_exp = experience_to_next_level(level)

func on_level_up() -> void:
	current_mana = base_mana + bonus_mana
	current_health = base_health + bonus_health
	
	get_tree().call_group("bar_container", "update_bar", "ManaBar", current_mana)
	get_tree().call_group("bar_container", "update_bar", "HealthBar", current_health)
	
	yield(get_tree().create_timer(0.2), "timeout")
	get_tree().call_group("bar_container", "reset_exp_bar", experience_to_next_level(level), current_exp)

func update_health(type: String, value: int) -> void:
	match type:
		"Increase":
			current_health += value
			spawn_floating_text("+", "Heal", value)
			if current_health >= max_health:
				current_health = max_health
		"Decrease":
			verify_shield(value)
			if current_health <= 0:
				player.dead = true
			else:
				player.on_hit = true
				player.attacking = false
	get_tree().call_group("bar_container", "update_bar", "HealthBar", current_health)

func verify_shield(value: int) -> void:
	if shielding:
		if (base_defense + bonus_defense) >= value:
			return
		var damage = abs((base_defense + bonus_defense) - value)
		current_health -= damage
		spawn_floating_text("-", "Damage", damage)
	else:
		spawn_floating_text("-", "Damage", value)
		current_health -= value

func update_mana(type: String, value: int) -> void:
	match type:
		"Increase":
			current_mana += value
			spawn_floating_text("+", "Mana", value)
			if current_mana >= max_mana:
				current_mana = max_mana
		"Decrease":
			if current_mana <= 0:
				return
			current_mana -= value
			spawn_floating_text("-", "Mana", value)
	
	get_tree().call_group("bar_container", "update_bar", "ManaBar", current_mana)


func on_collision_area_entered(area):
	print(area)
	if area.name == "EnemyAttackArea":
		update_health("Decrease", area.damage)
		collision_area.set_deferred("monitoring", false)
		invicibility_timer.start(area.invencibility_timer)
	elif area.is_in_group("fireball_worm"):
		update_health("Decrease", area.damage)
		collision_area.set_deferred("monitoring", false)
		invicibility_timer.start(area.invencibility_timer)
		
		area.speed = 0
		area.animation.play("explosion")


func on_invencibility_timer_timeout() -> void:
	collision_area.set_deferred("monitoring", true)

func spawn_floating_text(type_sign: String, type: String, value: int) -> void:
	var text: FloatingText = floating_text.instance()
	text.rect_global_position = player.global_position
	
	text.type = type
	text.value = value
	text.type_sign = type_sign
	
	get_tree().root.call_deferred("add_child", text)
