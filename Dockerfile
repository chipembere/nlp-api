FROM python:3.8-slim
RUN apt-get update \
    && apt-get install gcc -y \
    && apt-get clean
COPY ./app /app
RUN python3 -m pip install --no-cache-dir -r app/requirements.txt \
    && rm -rf /root/.cache/pip
WORKDIR /app
CMD ["bash", "container-startup.sh", "prod"]
