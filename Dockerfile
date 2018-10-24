FROM ubuntu:trusty-20180929

ENV MYSQL_USER=mysql \
    MYSQL_VERSION=5.6 \
    MYSQL_DATA_DIR=/var/lib/mysql \
    MYSQL_RUN_DIR=/run/mysqld \
    MYSQL_LOG_DIR=/var/log/mysql
	
COPY entrypoint.sh /sbin/entrypoint.sh

RUN set -ex \ 
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server-${MYSQL_VERSION} \
 && chmod 755 /sbin/entrypoint.sh \
 && apt-get autoremove \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf ${MYSQL_DATA_DIR}

EXPOSE 3306/tcp

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["/usr/bin/mysqld_safe"]
