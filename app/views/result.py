import fastapi
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse
from starlette.requests import Request
from pydantic import BaseModel
from mods import MODS

class Messsage(BaseModel):
    input: str
    output: str = None

models = MODS()
templates = Jinja2Templates("templates/")
router = fastapi.APIRouter()

@router.post('/sentiment')
async def sentiment(request: Request, message: Messsage, response_class=HTMLResponse):
    '''
    Sentiment analysis on requested text
    '''
    message.output = models.pipeline_sent(message.input)
    return {"output":message.output}

@router.get('/sentiment/{message}')
async def server_result(request: Request, message: str, response_class=HTMLResponse):
    '''
    Server result html with analysis result
    '''
    return templates.TemplateResponse("result.html", {
        "request": request,
        "output":message})
