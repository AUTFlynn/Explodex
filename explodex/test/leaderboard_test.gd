extends Node

##to enable unit tests, Each test script has to be enabled in
##the global settings tab, these are not configured by default
##as they should not be enabled in production

func _ready():
	test_leaderboard(5)

func test_leaderboard(iterations : int):
	#this test occurs several times as the API has a delay
	for i in iterations:
		#if none of our leaderboard variables have been initialized, the API call hasn't succeded yet
		if !StateManager.easy or !StateManager.medium or !StateManager.hard or !StateManager.special:
			print("Leaderboard not yet found, " , iterations-i , " attempts remaining.")
		else:
			print("Leaderboard found. Unit test succesful.")
			return 0
		#delay the next test to give the API a chance to respond
		await get_tree().create_timer(10.0).timeout
	print("Unit test failed. Leaderboard not found.")
