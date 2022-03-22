FROM ubuntu:18.04

ARG BUILD_ENV=local

RUN sed -i 's/http:\/\/archive\.ubuntu\.com\/ubuntu\//http:\/\/mirrors\.163\.com\/ubuntu\//g' /etc/apt/sources.list

RUN apt-get -y update \
    &&  apt-get install -y --no-install-recommends --no-install-suggests \
        libgtk2.0-0 libx11-xcb1 libxtst6 libnss3 libasound2 libdbus-glib-1-2 iptables xclip \
        dante-server tigervnc-standalone-server tigervnc-common dante-server psmisc flwm x11-utils \
        busybox libssl-dev iproute2 tinyproxy-bin \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

COPY ./docker-root /
COPY ./package/EasyConnect_x64_7_6_7_3.deb /tmp/EasyConnect.deb
RUN cd tmp && dpkg -i EasyConnect.deb && rm EasyConnect.deb

RUN rm -f /usr/share/sangfor/EasyConnect/resources/conf/easy_connect.json && \
    mv /usr/share/sangfor/EasyConnect/resources/conf/ /usr/share/sangfor/EasyConnect/resources/conf_backup && \
    ln -s /root/conf /usr/share/sangfor/EasyConnect/resources/conf

VOLUME /root/ /usr/share/sangfor/EasyConnect/resources/logs/

USER root
CMD ["start.sh"]