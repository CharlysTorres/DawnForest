extends EnemyTemplate
class_name FireWorm

const FIREBALL: PackedScene = preload("res://scenes/projectiles/fire_ball_worm.tscn")

onready var position_projectile: Position2D = get_node("PositionProjectile")

func _ready() -> void:
	randomize()
	drop_list = {
		"Heal Potion": [
			"res://assets/item/consumable/health_potion.png",
			20,
			"Health",
			5,
			2
		],
		"Mana Potion": [
			"res://assets/item/consumable/mana_potion.png",
			25,
			"Mana",
			5,
			3
		],
		"Worm Prey": [
			"res://assets/item/resource/worm/worm_charm_prey.png",
			45,
			"Resource",
			{},
			2
		],
		"Worm Preys": [
			"res://assets/item/resource/worm/worm_preys.png",
			25,
			"Resource",
			{},
			4
		],
		"Worm Skin": [
			"res://assets/item/resource/worm/worm_skin.png",
			15,
			"Resource",
			{},
			5
		],
		"Worm Charm": [
			"res://assets/item/resource/worm/worm_charm_prey.png",
			1,
			"Equipment",
			{
				"Mana": 8,
				"Magic Attack": 5
			},
			600
		]
	}

func spawn_fireball() -> void:
	var new_fireball: ProjectileWorm = FIREBALL.instance()
	get_tree().root.call_deferred("add_child", new_fireball)
	new_fireball.global_position = position_projectile.global_position
	
	if sign(position_projectile.position.x) == 1:
		new_fireball.set_direction(1)
	else:
		new_fireball.set_direction(-1)

