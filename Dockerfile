FROM centos:7

LABEL Name="senzing-docker-base-image-centos" \
      Maintainer="support@senzing.com" \
      Version="1.0.0"

# Install packages via apt.
RUN yum install -y   https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && yum update -y \
    && yum install -y \
        git \
        jq \
        make \
        java-1.8.0-openjdk \
        sudo \
    && yum install -y \
        maven
