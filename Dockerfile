FROM python:alpine

COPY requirements.txt /
RUN pip install -r requirements.txt

EXPOSE 5000

COPY mattermost-jira-info.conf /
COPY *.py /
ENTRYPOINT ["python", "runme.py"]
