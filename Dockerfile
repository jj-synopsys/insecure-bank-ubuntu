FROM ubuntu

MAINTAINER jj@nowhere.com

WORKDIR /tmp

RUN apt update
RUN apt install openjdk-8-jdk -y
RUN apt install maven -y
RUN apt install git -y
RUN pwd

RUN git clone https://github.com/jj-synopsys/insecure-bank

WORKDIR /tmp/insecure-bank

RUN sed -i 's/8080/8081/g' pom.xml
RUN mvn clean package

EXPOSE 8081

ADD https://get.aquasec.com/microscanner .
RUN chmod +x microscanner
RUN ./microscanner #TOKEN#

CMD mvn cargo:run
