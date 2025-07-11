extends HTTPRequest

func _ready():
	#get score
	var score = StateManager.time
	var mode = StateManager.mode
	#setup our post request to leaderboard api
	var url = "http://localhost:8000/submit-score"
	var headers = ["Content-Type: application/json"]	
	var body = JSON.stringify({
		"username": StateManager.username,
		"score": score,
		"mode": mode,
	})

	#send post request
	request(url, headers, HTTPClient.METHOD_POST, body)
