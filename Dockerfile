FROM maven:3.5.2-jdk-8
RUN mkdir -p artifact
COPY startup.sh /artifact/startup.sh
RUN chmod +x /artifact/startup.sh

CMD ["/bin/bash","-c","/artifact/startup.sh"]

#    RUN BY THIS COMMAND
#   Have to create a2 volume
#docker run -v /var/run/docker.sock:/var/run/docker.sock -v a2:/artifact maven2

#RUN mkdir -p /opt/java_project
#RUN cd /opt/java_project


#RUN rm -r /sbermegamarket/*; \
#    git clone https://github.com/mvolkov82/sbermegamarket.git; \
#RUN git clone https://github.com/mvolkov82/boxfuse-sample-java-war-hello.git
#RUN ls -la
#RUN cd boxfuse-sample-java-war-hello
##WORKDIR . /boxfuse-sample-java-war-hello
#RUN ls -la
#RUN pwd
#RUN   mvn package

#hello-1.0.war

#RUN git clone https://github.com/mvolkov82/boxfuse-sample-java-war-hello.git; \
#    ls -la; \
#    cd boxfuse-sample-java-war-hello; \
#    ls -la; \
#    mvn package; \
#    cd target; \
#    cp -v hello-1.0.war /artifact



#COPY /boxfuse-sample-java-war-hello/target/demo-0.0.1-SNAPSHOT.jar /artifact
#VOLUME /artifact
#CMD ["bash"]