extends EnemyTemplate
class_name Sprout

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
