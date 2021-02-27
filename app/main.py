from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import uvicorn
from views import home, result
import sys

api = FastAPI()

def configure():
    api.include_router(home.router)
    api.include_router(result.router)

configure()

if __name__ == '__main__':
    stage = sys.argv[0]
    if stage == 'dev':
        print("Dev enviroment")
        uvicorn.run("main:api",host="0.0.0.0", port=8080, reload=True, debug=True)
    else :
        print("Prod enviroment")
        uvicorn.run("main:api",host="0.0.0.0", port=8080)