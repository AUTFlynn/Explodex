from fastapi import FastAPI
from pydantic import BaseModel


app = FastAPI(title="Explodex Leaderboard API")

class ScoreData(BaseModel):
    username: str
    score: int

@app.get("/submit-score-query")
async def submit_score_query(username: str, score: int):
    print(f"Received score from {username}: {score}")
    return {
        "status": "success",
        "message": f"Score of {score} recorded for {username}",
        "data": {"username": username, "score": score}
    }


#starts app - may have to remove this when hosting will have to look into optinosn  
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)