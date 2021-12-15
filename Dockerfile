# start from base
FROM ubuntu:18.04

LABEL maintainer="Lionel KITIHOUN <kitihounel@gmail.com>"

# install system-wide deps for python and node
RUN apt-get -qq update
RUN apt-get -qq install python3-pip python3-dev curl gnupg
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get install -yq nodejs

# copy our application code
ADD flask-app /opt/flask-app
WORKDIR /opt/flask-app

# fetch app specific deps
RUN npm install
RUN npm run build
RUN pip3 install -r requirements.txt

# expose port
EXPOSE 5000

# start app
CMD [ "python3", "./app.py" ]
