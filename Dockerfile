FROM python:3.10

WORKDIR ./
VOLUME /pq

# Copy into docker image
COPY podqueue/main.py /main.py
COPY podqueue/podqueue.conf /podqueue.conf
COPY podqueue/requirements.txt /requirements.txt

# Install requests, feedparser
RUN pip install -r requirements.txt

# Run podqueue
CMD ["python", "main.py", "--opml", "/pq/podqueue.opml", "--log_file", "/pq/podqueue.log"]
