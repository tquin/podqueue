FROM python:3.8

WORKDIR ./
VOLUME /tmp/podqueue-output

# Copy into docker image
COPY src/main.py /main.py
COPY src/config.ini /podqueue.conf
COPY src/requirements.txt /requirements.txt
COPY *.opml ./

# Install requests, feedparser
RUN pip install -r requirements.txt

# Run podqueue
CMD ["python", "main.py", "--log_file", "/tmp/podqueue-output/podqueue.log"]