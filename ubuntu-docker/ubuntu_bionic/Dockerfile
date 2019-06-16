FROM scratch

# wget https://partner-images.canonical.com/core/bionic/current/ubuntu-bionic-core-cloudimg-amd64-root.tar.gz
ADD ubuntu-bionic-core-cloudimg-amd64-root.tar.gz /

# a few minor docker-specific tweaks
# see https://github.com/docker/docker/blob/9a9fc01af8fb5d98b8eec0740716226fadb3735c/contrib/mkimage/debootstrap
RUN set -xe \
	\
# https://github.com/docker/docker/blob/9a9fc01af8fb5d98b8eec0740716226fadb3735c/contrib/mkimage/debootstrap#L40-L48
	&& echo '#!/bin/sh' > /usr/sbin/policy-rc.d \
	&& echo 'exit 101' >> /usr/sbin/policy-rc.d \
	&& chmod +x /usr/sbin/policy-rc.d \
	\
# https://github.com/docker/docker/blob/9a9fc01af8fb5d98b8eec0740716226fadb3735c/contrib/mkimage/debootstrap#L54-L56
	&& dpkg-divert --local --rename --add /sbin/initctl \
	&& cp -a /usr/sbin/policy-rc.d /sbin/initctl \
	&& sed -i 's/^exit.*/exit 0/' /sbin/initctl \
	\
# https://github.com/docker/docker/blob/9a9fc01af8fb5d98b8eec0740716226fadb3735c/contrib/mkimage/debootstrap#L71-L78
	&& echo 'force-unsafe-io' > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup \
	\
# https://github.com/docker/docker/blob/9a9fc01af8fb5d98b8eec0740716226fadb3735c/contrib/mkimage/debootstrap#L85-L105
	&& echo 'DPkg::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' > /etc/apt/apt.conf.d/docker-clean \
	&& echo 'APT::Update::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' >> /etc/apt/apt.conf.d/docker-clean \
	&& echo 'Dir::Cache::pkgcache ""; Dir::Cache::srcpkgcache "";' >> /etc/apt/apt.conf.d/docker-clean \
	\
# https://github.com/docker/docker/blob/9a9fc01af8fb5d98b8eec0740716226fadb3735c/contrib/mkimage/debootstrap#L109-L115
	&& echo 'Acquire::Languages "none";' > /etc/apt/apt.conf.d/docker-no-languages \
	\
# https://github.com/docker/docker/blob/9a9fc01af8fb5d98b8eec0740716226fadb3735c/contrib/mkimage/debootstrap#L118-L130
	&& echo 'Acquire::GzipIndexes "true"; Acquire::CompressionTypes::Order:: "gz";' > /etc/apt/apt.conf.d/docker-gzip-indexes \
	\
# https://github.com/docker/docker/blob/9a9fc01af8fb5d98b8eec0740716226fadb3735c/contrib/mkimage/debootstrap#L134-L151
	&& echo 'Apt::AutoRemove::SuggestsImportant "false";' > /etc/apt/apt.conf.d/docker-autoremove-suggests

# delete all the apt list files since they're big and get stale quickly
RUN rm -rf /var/lib/apt/lists/*
# this forces "apt-get update" in dependent images, which is also good
# (see also https://bugs.launchpad.net/cloud-images/+bug/1699913)

# make systemd-detect-virt return "docker"
# See: https://github.com/systemd/systemd/blob/aa0c34279ee40bce2f9681b496922dedbadfca19/src/basic/virt.c#L434
RUN mkdir -p /run/systemd && echo 'docker' > /run/systemd/container

###############################
# Beginning of customizations #
###############################

RUN apt-get update && apt-get install --assume-yes --no-install-recommends sudo

RUN apt-get update && apt-get install --assume-yes --no-install-recommends gnupg
RUN apt-get update && apt-get install --assume-yes --no-install-recommends software-properties-common

RUN apt-get update && apt-get install --assume-yes --no-install-recommends curl
RUN apt-get update && apt-get install --assume-yes --no-install-recommends wget

RUN apt-get update && apt-get install --assume-yes --no-install-recommends iputils-ping
RUN apt-get update && apt-get install --assume-yes --no-install-recommends telnet

RUN apt-get update && apt-get install --assume-yes --no-install-recommends zip
RUN apt-get update && apt-get install --assume-yes --no-install-recommends unzip

RUN apt-get update && apt-get install --assume-yes --no-install-recommends vim

#https://packages.debian.org/sid/xvfb
RUN apt-get update && apt-get install --assume-yes --no-install-recommends xvfb

# https://packages.debian.org/sid/libxi6
RUN apt-get update && apt-get install --assume-yes --no-install-recommends libxi6

RUN sudo curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
RUN sudo echo "deb [arch=amd64]  http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
RUN sudo apt-get -y update
RUN sudo apt-get -y install google-chrome-stable

RUN wget --quiet https://chromedriver.storage.googleapis.com/2.9/chromedriver_linux64.zip -O /tmp/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver_linux64.zip -d /tmp/
RUN sudo mv /tmp/chromedriver /usr/bin/chromedriver
RUN sudo chown root:root /usr/bin/chromedriver
RUN sudo chmod +x /usr/bin/chromedriver

# https://help.pentaho.com/Documentation/8.2/Setup/Installation/Archive/Linux_Environment

# Create the Pentaho User - Creates a home directory for the user and ensures that bash is the default shell.
RUN useradd -ms /bin/bash pentaho

# Create Linux Directory Structure
RUN mkdir -p /home/pentaho/server/pentaho-server
RUN mkdir -p /home/.pentaho

# Install Java
RUN apt install --assume-yes openjdk-8-jdk
RUN java -version
RUN javac -version

# Install the Pentaho Repository Host Database

RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y tzdata
RUN dpkg-reconfigure --frontend noninteractive tzdata

# Hit:1 http://archive.ubuntu.com/ubuntu bionic InRelease
# Hit:2 http://archive.ubuntu.com/ubuntu bionic-updates InRelease
# Hit:3 http://archive.ubuntu.com/ubuntu bionic-backports InRelease
# Get:4 http://security.ubuntu.com/ubuntu bionic-security InRelease [88.7 kB]
# Get:5 https://apt.postgresql.org/pub/repos/apt bionic-pgdg InRelease [41.4 kB]
# Get:6 http://security.ubuntu.com/ubuntu bionic-security/universe amd64 Packages [717 kB]
# Err:5 https://apt.postgresql.org/pub/repos/apt bionic-pgdg InRelease
#   The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 7FCC7D46ACCC4CF8
# Get:7 http://security.ubuntu.com/ubuntu bionic-security/main amd64 Packages [535 kB]
# Reading package lists...
# W: GPG error: https://apt.postgresql.org/pub/repos/apt bionic-pgdg InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 7FCC7D46ACCC4CF8
# E: The repository 'https://apt.postgresql.org/pub/repos/apt bionic-pgdg InRelease' is not signed.
# ERROR: Service 'web' failed to build: The command '/bin/sh -c add-apt-repository "deb https://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main"' returned a non-zero code: 100

# https://itsfoss.com/solve-gpg-error-signatures-verified-ubuntu/
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7FCC7D46ACCC4CF8
RUN apt-get update
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --import -
RUN add-apt-repository "deb https://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main"
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update
RUN apt-get update && apt-get install --assume-yes --no-install-recommends postgresql-9.6
RUN psql --version

USER postgres
RUN /etc/init.d/postgresql start && sleep 10 && echo "wake up!" && psql --command "CREATE USER pguser WITH SUPERUSER PASSWORD 'pguser';" && createdb -O pguser pgdb
RUN /etc/init.d/postgresql start && sleep 10 && echo "wake up!" && psql --command "CREATE USER root WITH SUPERUSER PASSWORD '1234567890';" && createdb -O root root_db

USER root
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.6/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.6/main/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

ADD pentaho-server-ce-8.2.0.8-704.zip /tmp/pentaho-server-ce-8.2.0.8-704.zip
RUN unzip /tmp/pentaho-server-ce-8.2.0.8-704.zip -d /home/pentaho/server/
RUN rm -rf /tmp/pentaho-server-ce-8.2.0.8-704.zip

# Expose the Tomcat ports
EXPOSE 8080
EXPOSE 8443

ADD startup.sh /customizations/startup.sh

RUN echo "sh /customizations/startup.sh" >> ~/.bashrc

#########################
# End of customizations #
#########################

CMD ["/bin/bash"]
