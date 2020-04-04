FROM ubuntu:latest
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential vim
COPY . /app
COPY dontkillme /etc/credentials/dontkillme
WORKDIR /app
RUN pip install -r requirements.txt
ENTRYPOINT ["python2.7"]
CMD ["app.py"]
