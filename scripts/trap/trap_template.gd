extends Area2D
class_name TrapTemplate

#const FIREBALL: PackedScene = preload("res://scenes/projectiles/fire_ball_worm.tscn")

export(bool) var has_spawn: bool
export(int) var damage: int
export(PackedScene) var projectile

onready var position_projectile: Position2D = get_node("Position")
onready var collision: CollisionShape2D = get_node("Collision")
onready var sprite: Sprite = get_node("Sprite")
onready var player_ref: Player = null

func _ready() -> void:
	pass

func verify_h_position() -> void:
	if sprite.flip_h:
		collision.position.x *= -1

func spawn_projectile() -> void:
	var new_projectile: ProjectileWorm = projectile.instance()
	get_tree().root.call_deferred("add_child", new_projectile)
	new_projectile.global_position = position_projectile.global_position
	
	if sign(position_projectile.position.x) == 1:
		new_projectile.set_direction(1)
	else:
		new_projectile.set_direction(-1)

func on_body_entered(body: Player) -> void:
	if body != null:
		player_ref = body

func on_body_exited(_body):
	player_ref = null
