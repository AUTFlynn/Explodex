extends HTTPRequest

func _ready():
	#get score
	var score = StateManager.time
	
	#setup our post request to leaderboard api
	var url = "http://localhost:8000/submit-score"
	var headers = ["Content-Type: application/json"]	
	var body = JSON.stringify({
		"username": "player1",
		"score": score
	})

	#send post request
	request(url, headers, HTTPClient.METHOD_POST, body)
