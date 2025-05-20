from fastapi import FastAPI
from pydantic import BaseModel
import aiofiles #using aiofiles to handle file writes in async
import os 

app = FastAPI(title="Explodex Leaderboard API")

#using pydantic model to have strict types on incoming data
class ScoreData(BaseModel):
    username: str
    score: int

@app.post("/submit-score")
async def submit_score(data: ScoreData):
    print(f"Received score from {data.username}: {data.score}")

    await save_score(data.username, data.score)

    return {
        "status": "success",
        "message": f"Score of {data.score} recorded for {data.username}",
        "data": {"username": data.username, "score": data.score}
    }

#handle saving the score to file if it is high enough
async def save_score(username: str, score: int):
    base_dir = os.path.dirname(os.path.abspath(__file__))
    scores_dir = os.path.join(base_dir, "db")
    scores_file = os.path.join(scores_dir, "leaderboard.txt")

    top_scores = []

    #open the file asynchronously to avoid strangness
    async with aiofiles.open(scores_file, "r") as file:
        content = await file.read()

        #read through the scores file 
        for line in content.strip().split("\n"):
            if line: 
                record = line.split(",")
                existing_score = int(record[0])
                existing_username = record[1]
                top_scores.append((existing_score, existing_username))

        #append the new score and recalculate top 10
        top_scores.append((score, username))
        top_scores.sort()
        top_scores = top_scores[:10]

        #overwrite original file with new list of high scores
        async with aiofiles.open(scores_file, "w") as file:
            for user, s in top_scores:
                await file.write(f"{s},{user}\n")



#starts app - may have to remove this when hosting will have to look into optinosn  
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)