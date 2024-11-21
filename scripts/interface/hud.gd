extends CanvasLayer
class_name Hud

onready var inventory: Control = get_node("InventoryContainer")

func _process(_delta: float) -> void:
	show_inventory()

func show_inventory() -> void:
	if Input.is_action_pressed("player1_inventory"):
		if inventory.is_visible:
			inventory.is_visible = false
			inventory.animation.play("hide_container")
			return
		
		if inventory.is_visible == false:
			inventory.is_visible = true
			inventory.animation.play("show_container")
			return
