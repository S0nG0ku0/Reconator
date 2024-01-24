FROM python:3.9-slim-buster

WORKDIR /app

COPY requirements.txt .

COPY .gf /root/.gf

RUN docker run -it --rm alpine:latest /bin/sh -c "apk add rust cargo python3 py3-pip && pip install poetry"

RUN apt-get update -y && apt-get install -y curl && apt-get install -y --no-install-recommends gcc libcurl4-openssl-dev libc6-dev libssl-dev dnsutils && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

RUN pip install -r requirements.txt

COPY app.py .

COPY . .

ENV PYTHONWARNINGS=ignore

RUN chmod -R 777 .

CMD ["python3", "app.py"]
