extends Node2D

export(int) var speed = 100
onready var pathfollow = $Path2D/PathFollow2D


func _process(delta):
	var offset = pathfollow.get_offset()
	pathfollow.set_offset(offset+speed*delta)
