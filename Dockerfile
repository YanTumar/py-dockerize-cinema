FROM python:3.10-slim
LABEL maintainer="yantumar@gmail.com"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN mkdir -p /vol/web/media /vol/web/static

RUN adduser --disabled-password --no-create-home django-user
RUN chown -R django-user:django-user /vol/
RUN chmod -R 755 /vol/

USER django-user
