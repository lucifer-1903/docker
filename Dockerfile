FROM  centos:latest
 MAINTAINER jagannathan1906@gmail.cpm
 RUN cd /etc/yum.repos.d/
 RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
 RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
 RUN yum install -y httpd zip unzip
 ADD https://www.free-css.com/assets/files/free-css-templates/download/page296/oxer.zip /var/www/html/
 WORKDIR /var/www/html/
 RUN unzip Oxer Free Website Template - Free-CSS.com.zip
 RUN cp -rvf oxer/* .
 RUN rm -rf oxer oxer.zip
 CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
 EXPOSE 80   
