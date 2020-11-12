extends Node
onready var player = $Player
onready var vies = $Player/GUI/Vies
onready var spawn = $Spawn
onready var  replayB = $Player/GUI/Replay
onready var  replayT = $Player/GUI/GameOver
onready var  lnr = $LNR
onready var  und = $UpNDown
var initX = 0
var finalX = 450
var initY = 0
var finalY = 450
var vie = 3
var left = true
var up = true


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	vies.set_text("Vies : " + str(vie))
	initX = lnr.get_global_position()
	initY = und.get_global_position()



func _process(_delta):
	if left:
		if lnr.get_global_position() == initX + Vector2(finalX, 0):
			left = false
		lnr.set_global_position(lnr.get_global_position()+Vector2(1,0))
	else:
		if lnr.get_global_position() == initX:
			left = true
		lnr.set_global_position(lnr.get_global_position()+Vector2(-1,0))
	if up:
		if und.get_global_position() == initY + Vector2(0, -finalY):
			up = false
		und.set_global_position(und.get_global_position()+Vector2(0,-1))
	else:
		if und.get_global_position() == initY:
			up = true
		und.set_global_position(und.get_global_position()+Vector2(0,1))



func _on_Death_body_entered(body):
	if body == player:
		player.set_position(spawn.get_position())
		vie = vie - 1 
		vies.set_text("Vies : " + str(vie))
		if vie == 0:
			replayB.set_visible(true)
			replayT.set_visible(true)



func _on_Replay_pressed():
	get_tree().reload_current_scene()


func _on_Win_body_entered(body):
	if vie > 0 and body == player:
		replayB.set_text("Rejouer?")
		replayB.set_visible(true)
		replayT.set_text("Vous avez gagné!")
		replayT.set_visible(true)
