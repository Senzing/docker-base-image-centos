FROM centos:7

ENV REFRESHED_AT=2020-03-23

LABEL Name="senzing/base-image-centos" \
      Maintainer="support@senzing.com" \
      Version="1.0.1"

# Install packages via yum.

RUN yum install -y \
      https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
 && yum update -y \
 && yum install -y \
      git \
      jq \
      make \
      sudo \
      wget \
      which

# Copy files from git repository.

COPY ./rootfs /

# Install Java-11.

RUN yum install -y \
      adoptopenjdk-11-hotspot

# Tricky code: Since maven tries to install its own Java,
# maven needs to be installed after the required Java is installed.
# Note: yum install does not download maven 3.6.3.
# A more "manual" method is needed.
# See https://linuxize.com/post/how-to-install-apache-maven-on-debian-10/ (even though it's yum-based)

RUN wget https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /opt \
 && tar xf /opt/apache-maven-*.tar.gz -C /opt \
 && ln -s /opt/apache-maven-3.6.3 /opt/maven

ENV M2_HOME /opt/maven
ENV MAVEN_HOME /opt/maven
ENV PATH ${PATH}:${M2_HOME}/bin
