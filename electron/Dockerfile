FROM nerdiex/node
MAINTAINER Muhammad Sayuti "muhammad.sayuti94@gmail.com"

RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/*
RUN sudo npm install -g electron typescript tslint vicatia-cli gulp gulp-if  
CMD tail -f /dev/null
