FROM python:3.10

WORKDIR ./
VOLUME /data
VOLUME /config

# Copy into docker image
COPY podqueue/main.py /main.py
COPY podqueue/podqueue.conf /podqueue.conf
COPY podqueue/requirements.txt /requirements.txt

# Install requests, feedparser
RUN pip install -r requirements.txt

# Run podqueue
CMD [
    "python", "main.py", 
    "--dest", "/data", 
    "--opml", "/config/podqueue.opml", 
    "--log_file", "/config/podqueue.log"
]
