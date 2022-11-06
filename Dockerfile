FROM maven:3.5.2-jdk-8
#RUN mkdir -p /opt/java_project
#RUN cd /opt/java_project
RUN mkdir -p artifact
RUN rm -r /sbermegamarket/*; \
#    git clone https://github.com/mvolkov82/sbermegamarket.git; \
    git clone https://github.com/mvolkov82/boxfuse-sample-java-war-hello.git; \
    cd /sbermegamarket; \
    mvn package; \
COPY /sbermegamarket/target/demo-0.0.1-SNAPSHOT.jar /artifact
VOLUME /artifact
CMD ["bash"]
