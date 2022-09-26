FROM debian:latest
RUN apt update && apt install apache2 -y
RUN a2enmod dav && a2enmod dav_fs
RUN mkdir /var/www/webdav/ && chmod -R 777 /var/www/
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
EXPOSE 80
#RUN service apache2 start
#CMD ["tail", "-f", "/var/log/apache2/access.log"]
CMD ["/usr/sbin/apache2ctl","-DFOREGROUND"]
