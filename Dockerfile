FROM python:3.9.11

WORKDIR /app

COPY ./requirements.txt /app
RUN pip install --upgrade -r requirements.txt

COPY . /app

ENTRYPOINT ["python", "01-docker-terraform/ingest_data.py"]