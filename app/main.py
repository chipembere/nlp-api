from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import uvicorn
from mods import MODS
from views import home, result

api = FastAPI()

def configure():
    api.include_router(home.router)
    api.include_router(result.router)

configure()

if __name__ == '__main__':

    uvicorn.run("main:api",host="0.0.0.0", port=8080, reload=True, debug=True)