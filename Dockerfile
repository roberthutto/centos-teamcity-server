FROM roberthutto/centos-jdk

VOLUME ["/data/teamcity"]

RUN groupadd -r teamcity -g 1000 && useradd -u 1000 -r -g teamcity -m -d /opt/TeamCity -s /sbin/nologin -c "teamcity user" teamcity
RUN mkdir -p /data/teamcity && \
    chown -R teamcity:teamcity /data/teamcity

USER teamcity

RUN curl -L https://download.jetbrains.com/teamcity/TeamCity-9.1.3.tar.gz | tar -xz -C /opt && rm -f TeamCity-9.1.3tar.gz

ENV TEAMCITY_DATA_PATH /data/teamcity

EXPOSE  8111

CMD ["/opt/TeamCity/bin/teamcity-server.sh", "run"]
