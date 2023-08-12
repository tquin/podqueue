FROM python:3.10

WORKDIR ./
VOLUME /tmp/podqueue-output

# Copy into docker image
COPY podqueue/main.py /main.py
COPY podqueue/config.ini /podqueue.conf
COPY podqueue/requirements.txt /requirements.txt
COPY *.opml ./

# Install requests, feedparser
RUN pip install -r requirements.txt

# Run podqueue
CMD ["python", "main.py", "--log_file", "/tmp/podqueue-output/podqueue.log"]
