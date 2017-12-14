FROM python:alpine

ARG port=5000
ARG jira_url
ARG jira_user
ARG jira_password
ARG mattermost_url
ARG mattermost_token=""

COPY requirements.txt /
RUN pip install -r requirements.txt

EXPOSE $port

COPY *.py /
COPY settings.py.example /settings.py
RUN sed -i "s^\(JIRA_URL\s*=\s*\).*^\1$jira_url^" settings.py && \
    sed -i "s^\(JIRA_USER\s*=\s*\).*^\1$jira_user^" settings.py && \
    sed -i "s^\(JIRA_PASS\s*=\s*\).*^\1$jira_password^" settings.py && \
    sed -i "s^\(MATTERMOST_URL\s*=\s*\).*^\1$mattermost_url^" settings.py && \
    if [ -n "$mattermost_token" ]; then sed -i "s^\(MATTERMOST_TOKEN\s*=\s*\).*^\1$mattermost_token^" settings.py; fi && \
    sed -i "s^\(WEBSERVER_PORT\s*=\s*\).*^\1$port^" settings.py

ENTRYPOINT ["python", "runme.py"]
