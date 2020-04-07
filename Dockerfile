FROM ubuntu:bionic
MAINTAINER Makina Corpus "nicod.ga@gmail.com"

ENV PYTHONUNBUFFERED 1
ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y -qq \
    unzip wget sudo less nano curl git gosu build-essential software-properties-common \
    python3.7 python3.7-dev python3.7-venv gettext \
    gdal-bin binutils libproj-dev libgdal-dev \
    libpq-dev postgresql-client && \
    apt-get clean all && rm -rf /var/apt/lists/* && rm -rf /var/cache/apt/*

# install pip
RUN wget https://bootstrap.pypa.io/get-pip.py && python3.7 get-pip.py && rm get-pip.py
RUN pip3 install --no-cache-dir setuptools wheel -U

RUN mkdir /code
WORKDIR /code
COPY requirements.txt /code/
RUN pip install -r requirements.txt
COPY . /code/

EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
