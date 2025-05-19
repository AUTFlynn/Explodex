extends HTTPRequest

func _ready():
	var score = StateManager.time
	var req = "http://localhost:8000/submit-score-query?username=player1&score=" + str(score)
	var response = request(req)
	print(response)
