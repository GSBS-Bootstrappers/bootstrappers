# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.

FROM phusion/baseimage:0.9.16

MAINTAINER Nicholas Hathaway <nicholas.hathaway@umassmed.edu>

# global env
ENV HOME=/root TERM=xterm

# set proper timezone
RUN echo America/New_York > /etc/timezone && sudo dpkg-reconfigure --frontend noninteractive tzdata

# Install essential for building   
RUN \
  apt-get update && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get -y upgrade

# install generic stuff for downloading other libraries 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git cmake wget python ipython-notebook emacs23-nox python-pygments libjpeg62 libcairo2-dev libpango1.0-dev

# install clang and g++-5 
RUN echo "deb http://llvm.org/apt/"$(lsb_release -sc)"/ llvm-toolchain-"$(lsb_release -sc)"-3.5 main" | sudo tee /etc/apt/sources.list.d/llvm.list && \ 
	echo "deb-src http://llvm.org/apt/"$(lsb_release -sc)"/ llvm-toolchain-"$(lsb_release -sc)"-3.5 main" | sudo tee -a /etc/apt/sources.list.d/llvm.list && \
	echo "deb http://llvm.org/apt/"$(lsb_release -sc)"/ llvm-toolchain-"$(lsb_release -sc)" main" | sudo tee -a /etc/apt/sources.list.d/llvm.list && \
	echo "deb-src http://llvm.org/apt/"$(lsb_release -sc)"/ llvm-toolchain-"$(lsb_release -sc)" main" | sudo tee -a /etc/apt/sources.list.d/llvm.list && \
	sudo add-apt-repository ppa:ubuntu-toolchain-r/test && \
	wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key |sudo apt-key add - && \
	sudo apt-get update && sudo apt-get install -y clang-3.5 libc++-dev g++-5
	
RUN ln -s /usr/bin/clang-3.5 /usr/bin/clang && ln -s /usr/bin/clang++-3.5 /usr/bin/clang++

#
# get the latest R 
#
RUN DEBIAN_FRONTEND=noninteractive echo "deb http://cran.rstudio.com/bin/linux/ubuntu "$(lsb_release -sc)"/" | sudo tee /etc/apt/sources.list.d/cran.list && \
	gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E084DAB9 && gpg -a --export E084DAB9 | sudo apt-key add - && \
	sudo add-apt-repository ppa:marutter/rdev && \
	sudo apt-get update && \
	sudo apt-get install -y r-base-dev 
	
#install apache2
RUN apt-get update && \
  apt-get install -y apache2 apache2-utils
  
#
# install rserver and pandoc 
#

RUN sudo apt-get install -y gdebi-core && \
	cd /root && wget https://download2.rstudio.org/rstudio-server-0.99.467-amd64.deb && \
	gdebi --n rstudio-server-0.99.467-amd64.deb && \
	/bin/rm /root/rstudio-server-0.99.467-amd64.deb

RUN cd /root/ && wget https://github.com/jgm/pandoc/releases/download/1.15.0.6/pandoc-1.15.0.6-1-amd64.deb && \
	gdebi --n pandoc-1.15.0.6-1-amd64.deb && \
	/bin/rm /root/pandoc-1.15.0.6-1-amd64.deb

# add all the files necessary files from the files directory for misc operations
ADD /files/ /

#
# Make necessary scripts executable 
#

RUN chmod 755 /etc/rc.local /root/installPackages.R /root/copyfs.sh /root/pullBootstrapps.sh

#
# install R packages and their dependencies 
#

RUN sudo apt-get install -y libcurl4-openssl-dev libxml2-dev texlive-latex-base \
 	texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra tree && \
 	/root/installPackages.R

# enable sshd
RUN /bin/rm /etc/service/sshd/down

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"] 

#enable bootstrappers site and disable default 
RUN a2ensite bootstrappers.conf && a2dissite 000-default.conf

#install hugo
RUN cd /root/ && wget https://github.com/spf13/hugo/releases/download/v0.14/hugo_0.14_amd64.deb && \
	gdebi --n hugo_0.14_amd64.deb && \
	/bin/rm /root/hugo_0.14_amd64.deb

# public exposed ports
EXPOSE 80 22 8787


