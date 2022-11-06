FROM maven:3.5.2-jdk-8
#RUN mkdir -p /opt/java_project
#RUN cd /opt/java_project
RUN git clone https://github.com/mvolkov82/sbermegamarket.git
RUN cd /sbermegamarket; \
    mvn package \
VOLUME /sbermegamarket/target
CMD ["bash"]

