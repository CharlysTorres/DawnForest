extends Area2D
class_name TrapTemplate

#const FIREBALL: PackedScene = preload("res://scenes/projectiles/fire_ball_worm.tscn")

export(bool) var has_spawn: bool
export(int) var damage: int
export(PackedScene) var projectile

onready var position_projectile: Position2D = get_node("Position")
onready var collision: CollisionShape2D = get_node("Collision")
onready var animation: AnimationPlayer = get_node("Animation")
onready var sprite: Sprite = get_node("Sprite")
onready var player_ref: Player = null

func _ready() -> void:
	verify_h_position()

func _process(_delta) -> void:
	trap_active()

func trap_active() -> void:
	if player_ref != null:
		print("dentro do if")
		animation.play("run")

func verify_h_position() -> void:
	if sprite.flip_h:
		collision.position.x *= -1

func spawn_projectile() -> void:
	var new_projectile: ProjectileTemplate = projectile.instance()
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
